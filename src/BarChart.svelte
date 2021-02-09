<script>
	import { scale, fade, draw } from 'svelte/transition';
	export let male;
	export let female;
  export let total;

</script>

<div class="barchart">
  <span class="bg">
    <span class="line" style="width: {Math.round(female*100/total)}%;"> </span>
  </span>
  <span class="percentage" in:fade={{delay: 400}}>{Math.round(female*100/total)}% vrouwen</span>
</div>

<style>
.barchart {
 display: flex;
 align-items: center;
}
.barchart span {
  line-height: 21px;
  display: inline-block;
  height: 19px;
  font-family: "acumin-pro-extra-condensed", Sans-serif;
  font-weight: 800;
}
.bg {
  width: 150px;
  background: #dce9ef;
}
.line {
  background: #5098AB;
}
.percentage {
  font-size: 21px;
}
</style>
