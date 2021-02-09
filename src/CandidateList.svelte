<script>
	import { fade, fly } from 'svelte/transition';
	import Candidate from './Candidate.svelte';
	import BarChart from './BarChart.svelte';

	export let english = false;
	export let listid;
	export let listname;
	export let candidates;
	$: candidates.filter(c => c.gender == 'v').map((c,i) => c.femaleIndex = i);
	export let program;
	export let poll;
	var real_poll = (poll > 0) ? poll : 2;
</script>

<div class="next" data-poll="{poll}">
	<div class="logo list_{listid}" in:fade></div>
	<BarChart english={english} total={candidates ? candidates.length: 0} male={candidates.filter(c => c.gender == 'm').length} female={candidates.filter(c => c.gender == 'v').length} />
	<div class="listinfo">
		{#if program}
			<a class="program" href="{program}" rel="noopener noreferer" target="_blank">
				<span class="small">{english ? 'Program' : 'Programma'}</span>
				<span class="wide">{english ? 'View the Election Program' : 'Bekijk verkiezingsprogramma'} <div class="chevron"></div></span>
			</a>
		{/if}
	</div>
</div>
<ol>
{#each candidates as candidate, i (listid + '-' + candidate.id)}
	<li class:save={i < real_poll} value={candidate.candidateid} in:fly="{{ y: 300, delay: i * 50 }}"><Candidate poll={real_poll} {...candidate} /></li>
{/each}
</ol>

<style>
.logo {
	background-size: contain;
	background-repeat: no-repeat;
	background-position: left center;
	background-color: #ffffff;
	height: 4rem;
	width: 6rem;
	float: left;
	display: inline-block;
}
.listinfo {
	height: 4rem;
 display: flex;
 align-items: center;
 justify-content: right;
}

.program .wide {
	display: none;
}
@media (min-width: 768px) {
	.program .wide {
		display: inline;
	}
	.program .small {
		display: none;
	}
}
ol {
	list-style-type: none;
	padding: 0;
	margin: 0;
	clear: both;
}
li.save + li:not(.save) {
	border-top: 3px dashed #EC4752;
	padding-top: 0.5rem;
}
.next {
	height: 4rem;
	vertical-align: top;
	position: relative;
	display: inline-grid;
	grid-template-columns: 33% 33% 33%;
	width: 100%;
	margin-bottom: 2rem;
}
.next > div:nth-child(1) {
 display: flex;
 align-items: center;
}
a.program {
	display: inline-block;
	vertical-align: top;
	padding: 0.3rem 0.7rem 0.3rem 0.7rem;
	font-weight: bold;
	text-decoration: none;
	color: #4e96a9;
	font-family: "acumin-pro-extra-condensed", Sans-serif;
	font-size: 21px;
	line-height: 21px;
	text-transform: uppercase;
}
.chevron {
	position: absolute;
	right: 0;
	top: 0;
	width: 2rem;
	height: 100%;
	/* chevron-right */
	background: transparent right -0.4rem top 1.1rem no-repeat url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23CCC%22 d=%22M8.59,16.58L13.17,12L8.59,7.41L10,6L16,12L10,18L8.59,16.58Z%22/%3E%3C/svg%3E");
	background-size: 2rem;
	z-index: 2;
}
.program span:hover > .chevron {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23000%22 d=%22M8.59,16.58L13.17,12L8.59,7.41L10,6L16,12L10,18L8.59,16.58Z%22/%3E%3C/svg%3E");

}

</style>
