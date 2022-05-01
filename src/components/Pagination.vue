<template>
  <div>
    <br>
    <b-button :disabled="!prev" class="mr-2" :to="prev" variant="outline-light">Back</b-button>
    <b-button :disabled="!next" v-if="next" class="ml-2" :to="next" variant="light">Next</b-button>
  </div>
</template>
<script>
export default {
    name: "pagination",
    props:['prev', 'next'],
}
</script>