
// File: @chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol


pragma solidity ^0.8.0;

interface KeeperCompatibleInterface {
  /**
   * @notice method that is simulated by the keepers to see if any work actually
   * needs to be performed. This method does does not actually need to be
   * executable, and since it is only ever simulated it can consume lots of gas.
   * @dev To ensure that it is never called, you may want to add the
   * cannotExecute modifier from KeeperBase to your implementation of this
   * method.
   * @param checkData specified in the upkeep registration so it is always the
   * same for a registered upkeep. This can easily be broken down into specific
   * arguments using `abi.decode`, so multiple upkeeps can be registered on the
   * same contract and easily differentiated by the contract.
   * @return upkeepNeeded boolean to indicate whether the keeper should call
   * performUpkeep or not.
   * @return performData bytes that the keeper should call performUpkeep with, if
   * upkeep is needed. If you would like to encode data to decode later, try
   * `abi.encode`.
   */
  function checkUpkeep(bytes calldata checkData) external returns (bool upkeepNeeded, bytes memory performData);

  /**
   * @notice method that is actually executed by the keepers, via the registry.
   * The data returned by the checkUpkeep simulation will be passed into
   * this method to actually be executed.
   * @dev The input to this method should not be trusted, and the caller of the
   * method should not even be restricted to any single registry. Anyone should
   * be able call it, and the input should be validated, there is no guarantee
   * that the data passed in is the performData returned from checkUpkeep. This
   * could happen due to malicious keepers, racing keepers, or simply a state
   * change while the performUpkeep transaction is waiting for confirmation.
   * Always validate the data passed in.
   * @param performData is the data which was passed back from the checkData
   * simulation. If it is encoded, it can easily be decoded into other types by
   * calling `abi.decode`. This data should not be trusted, and should be
   * validated against the contract's current state.
   */
  function performUpkeep(bytes calldata performData) external;
}

// File: @chainlink/contracts/src/v0.8/KeeperBase.sol


pragma solidity ^0.8.0;

contract KeeperBase {
  error OnlySimulatedBackend();

  /**
   * @notice method that allows it to be simulated via eth_call by checking that
   * the sender is the zero address.
   */
  function preventExecution() internal view {
    if (tx.origin != address(0)) {
      revert OnlySimulatedBackend();
    }
  }

  /**
   * @notice modifier that allows it to be simulated via eth_call by checking
   * that the sender is the zero address.
   */
  modifier cannotExecute() {
    preventExecution();
    _;
  }
}

// File: @chainlink/contracts/src/v0.8/KeeperCompatible.sol


pragma solidity ^0.8.0;



abstract contract KeeperCompatible is KeeperBase, KeeperCompatibleInterface {}

// File: @openzeppelin/contracts/token/ERC721/IERC721Receiver.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC721/IERC721Receiver.sol)

pragma solidity ^0.8.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

// File: DotDotDotPrinter.sol

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