pragma solidity ^0.8.10;
interface IWETH {
  function transferFrom ( address src, address dst, uint256 wad ) external returns ( bool );
  function withdraw ( uint256 wad ) external;
  function balanceOf ( address ) external view returns ( uint256 );
  function transfer ( address dst, uint256 wad ) external returns ( bool );
  function allowance ( address, address ) external view returns ( uint256 );
}

interface IDotDotDot {
  function MAX_NFT_PURCHASE (  ) external view returns ( uint256 );
  function MAX_SUPPLY (  ) external view returns ( uint256 );
  function NFT_PRICE (  ) external view returns ( uint256 );
  function balanceOf ( address owner ) external view returns ( uint256 );
  function mint ( uint256 numberOfTokensMax5 ) payable external;
  function safeTransferFrom ( address from, address to, uint256 tokenId ) external;
  function tokenOfOwnerByIndex ( address owner, uint256 index ) external view returns ( uint256 );
  function totalSupply (  ) external view returns ( uint256 );
}
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@chainlink/contracts/src/v0.8/KeeperCompatible.sol";
contract DotDotDotPrinter is KeeperCompatibleInterface, IERC721Receiver {
    address public constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    IWETH constant WETH = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IDotDotDot DotDotDots; 
    address owner;
    uint256 fee = 0;
    constructor(address nft){
        DotDotDots = IDotDotDot(nft); //0xce25e60a89f200b1fa40f6c313047ffe386992c3
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
        // Only current owner can set a new owner to the contract. 
    function newOwner(address _owner) external onlyOwner {
        owner = _owner;
    }
    function withdraw(address _token) external onlyOwner {
        if(_token == ETH){
          (bool success, /*bytes memory data*/) = owner.call{value: address(this).balance}("");
          require(success);
          return;
        }
        IWETH Token = IWETH(_token);
        Token.transfer(owner, Token.balanceOf(address(this)));
    }
    
    function setFee(uint256 _fee) external onlyOwner {
        fee = _fee;
    }
    function checkUpkeep(bytes calldata checkData) external view returns(bool upkeepNeeded, bytes memory performData){
        (address buyer, uint256 amount) = abi.decode(checkData, (address, uint256));
        if(amount > DotDotDots.MAX_NFT_PURCHASE()){
            revert("You can't purchase that many tokens at one time");
        }
        uint256 supply = DotDotDots.totalSupply();
        uint256 max = DotDotDots.MAX_SUPPLY();
        uint256 price = (amount * DotDotDots.NFT_PRICE()) + fee;
        uint256 allowance = WETH.allowance(buyer, address(this));
        if(supply < max && allowance >= price){ return (true, checkData); }
        else { return (false, checkData); }
    }
    function performUpkeep(bytes calldata performData) external {
        (address buyer, uint256 amount) = abi.decode(performData, (address, uint256));
        if(amount > DotDotDots.MAX_NFT_PURCHASE()){
            revert("You can't purchase that many tokens at one time");
        }
        uint256 beforeNFT = DotDotDots.balanceOf(buyer);
        uint256 beforeBalance = WETH.balanceOf(buyer);
        uint256 price = (DotDotDots.NFT_PRICE() * amount) + fee;
        WETH.transferFrom(buyer, address(this), price);
        WETH.withdraw(price);
        DotDotDots.mint{value:price}(amount);
        for(uint256 i; i < amount; i++){
            uint256 tokenId = DotDotDots.tokenOfOwnerByIndex(address(this), i);
            DotDotDots.safeTransferFrom(address(this), buyer, tokenId);
        }
        // Sanity checks
        if(WETH.balanceOf(buyer) != beforeBalance - price){
            revert("Buyer didn't pay for the NFTs");
        }
        if(DotDotDots.balanceOf(buyer) != beforeNFT + amount) {
            revert("Buyer didn't get the NFTs");
        }
    }
    receive() external payable {}
    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}