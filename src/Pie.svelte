<script>
	import { scale, fade, draw } from 'svelte/transition';
	export let male;
	export let female;
$: total = male + female;
$: maleDegree = Math.min(male / total * 360, 359.9);
$: femaleDegree = Math.min(female / total * 360, 359.9);

// Based on https://stackoverflow.com/a/18473154/589293 with added flip option
function polarToCartesian(centerX, centerY, radius, angleInDegrees) {
  const angleInRadians = (angleInDegrees-90) * Math.PI / 180.0;

  return {
    x: centerX + (radius * Math.cos(angleInRadians)),
    y: centerY + (radius * Math.sin(angleInRadians))
  };
}
function describeArc(x, y, radius, startAngle, endAngle, flip){

    const start = polarToCartesian(x, y, radius, endAngle);
    const end = polarToCartesian(x, y, radius, startAngle);

    const largeArcFlag = endAngle - startAngle <= 180 ? "0" : "1";

    const d = [
        "M", flip ? end.x : start.x, flip ? end.y : start.y,
        "A", radius, radius, 0, largeArcFlag, flip ? 1 : 0, flip ? start.x : end.x, flip ? start.y : end.y
    ].join(" ");

    return d;
}
</script>

<svg viewBox="0 0 100 100">
	<!-- <circle cx="50" cy="50" r="50" fill="#FFF" /> -->
	<path in:draw fill="none" stroke="#4e96a9" stroke-width="15" d="{describeArc(50, 50, 42, 0, maleDegree, true)}" />
  <path in:draw fill="none" stroke="#e94551" stroke-width="15" d="{describeArc(50, 50, 42, maleDegree, 360)}" />
	<text in:fade={{delay: 400}} x="50" y="50" dy="0.3em" font-size="1.8rem" font-weight="bolder" fill="#ee956a" text-anchor="middle">{Math.round(female*100/total)}%</text>
</svg>

<style>
svg {
	width: 4rem;
	height: 4rem;
	margin-left: 0.5rem;
	float: right;
}
</style>