<script>
	import { scale, fade, draw } from 'svelte/transition';
	export let male;
	export let female;
  export let total;

</script>

<svg viewBox="0 0 100 100" data-total="{total}" data-male="{male}" data-female="{female}">
	<!-- <circle cx="50" cy="50" r="50" fill="#FFF" /> -->
  <g class='bars'>
    <rect fill='#dce9ef' width='100%' height='25'></rect>;
    <rect fill='#5098AB' width='{Math.round(female*100/total)}%' height='25'></rect>
    <text in:fade={{delay: 400}} x="50" y="50" dy="0.3em" font-size="1.8rem" font-weight="bolder" fill="#ee956a" text-anchor="middle">{Math.round(female*100/total)}%</text>
  </g>
</svg>

<style>
svg {
	width: 4rem;
	height: 4rem;
	margin-left: 0.5rem;
	float: right;
}
</style>
