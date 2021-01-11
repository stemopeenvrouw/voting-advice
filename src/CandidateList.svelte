<script>
	import { fade, fly } from 'svelte/transition';
	import Candidate from './Candidate.svelte';
	import Pie from './Pie.svelte';

	export let english = false;
	export let listid;
	export let listname;
	export let candidates;
	$: candidates.filter(c => c.gender == 'v').map((c,i) => c.femaleIndex = i);
	export let program;
	export let poll;
</script>

<div class="next">
	<button class="back" on:click aria-label="{english ? 'Back' : 'Terug'}">{english ? 'Back' : 'Terug'}</button><br>
	<div class="logo list_{listid}" in:fade></div>
	<div class="listinfo">
		<h3>{listname}</h3>
		{#if program}
			<a class="program" href="{program}" rel="noopener noreferer" target="_blank">
				<span class="small">{english ? 'Program (PDF NL)' : 'Programma (PDF)'}</span>
				<span class="wide">{english ? 'Election Program (PDF NL)' : 'Verkiezingsprogramma (PDF)'}</span>
			</a>
		{/if}
	</div>
	<Pie male={candidates.filter(c => c.gender == 'm').length} female={candidates.filter(c => c.gender == 'v').length} />
</div>
<ol>
{#each candidates as candidate, i (listid + '-' + candidate.id)}
	<li class:save={i < poll} value={candidate.candidateid} in:fly="{{ y: 300, delay: i * 50 }}"><Candidate {...candidate} /></li>
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
	float: left;
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
	border-top: 3px dashed #4e96a9;
	padding-top: 0.5rem;
}
.next {
	display: block;
	height: 4rem;
	vertical-align: top;
	position: relative;
}
a.program {
	display: inline-block;
	vertical-align: top;
	padding: 0.3rem 0.7rem 0.3rem 0.7rem;
	color: #fff;
	font-weight: bold;
	text-decoration: none;
	background: #4e96a9;
	/*background: #4e96a9 no-repeat center right 0.4rem url("data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%2212%22 height=%2212%22%3E %3Cpath fill=%22%234e96a9%22 stroke=%22%23FFF%22 d=%22M1.5 4.518h5.982V10.5H1.5z%22/%3E %3Cpath fill=%22%23FFF%22 d=%22M5.765 1H11v5.39L9.427 7.937l-1.31-1.31L5.393 9.35l-2.69-2.688 2.81-2.808L4.2 2.544z%22/%3E %3Cpath fill=%22%234e96a9%22 d=%22M9.995 2.004l.022 4.885L8.2 5.07 5.32 7.95 4.09 6.723l2.882-2.88-1.85-1.852z%22/%3E %3C/svg%3E");*/
	/*background: #4e96a9 no-repeat center right 0.4rem url("data:image/svg+xml,%3Csvg viewBox=%220 0 24 24%22%3E%3Cpath d=%22M14%2C2L20%2C8V20A2%2C2 0 0%2C1 18%2C22H6A2%2C2 0 0%2C1 4%2C20V4A2%2C2 0 0%2C1 6%2C2H14M18%2C20V9H13V4H6V20H18M10.92%2C12.31C10.68%2C11.54 10.15%2C9.08 11.55%2C9.04C12.95%2C9 12.03%2C12.16 12.03%2C12.16C12.42%2C13.65 14.05%2C14.72 14.05%2C14.72C14.55%2C14.57 17.4%2C14.24 17%2C15.72C16.57%2C17.2 13.5%2C15.81 13.5%2C15.81C11.55%2C15.95 10.09%2C16.47 10.09%2C16.47C8.96%2C18.58 7.64%2C19.5 7.1%2C18.61C6.43%2C17.5 9.23%2C16.07 9.23%2C16.07C10.68%2C13.72 10.9%2C12.35 10.92%2C12.31M11.57%2C13.15C11.17%2C14.45 10.37%2C15.84 10.37%2C15.84C11.22%2C15.5 13.08%2C15.11 13.08%2C15.11C11.94%2C14.11 11.59%2C13.16 11.57%2C13.15M14.71%2C15.32C14.71%2C15.32 16.46%2C15.97 16.5%2C15.71C16.57%2C15.44 15.17%2C15.2 14.71%2C15.32M9.05%2C16.81C8.28%2C17.11 7.54%2C18.39 7.72%2C18.39C7.9%2C18.4 8.63%2C17.79 9.05%2C16.81M11.57%2C11.26C11.57%2C11.21 12%2C9.58 11.57%2C9.53C11.27%2C9.5 11.56%2C11.22 11.57%2C11.26Z%22 /%3E %3C/svg%3E");
	background-size: contain;*/
}
h3 {
	margin: 0;
	color: #4e96a9;/*#ee956a;*/
	bottom: 0;
	margin-bottom: 0.9rem;
	/*position: absolute;*/
}
.back {
	display: inline-block;
	border: none;
	font-weight: bold;
	background: none;
	vertical-align: bottom;
	padding: 0.3rem 0.7rem 0.3rem 1.7rem;
	font-family: inherit;
	font-size: inherit;
	border-radius: none;
	appearance: none;
	cursor: pointer;
	margin: 0;
	transition: all ease-in-out 0.3s;
	/* chevron-left */
	background: transparent left center no-repeat url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 width=%2224%22 height=%2224%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23000%22 d=%22M15.41,16.58L10.83,12L15.41,7.41L14,6L8,12L14,18L15.41,16.58Z%22/%3E%3C/svg%3E");
}
.back:hover {
	background: #000 left center no-repeat url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 width=%2224%22 height=%2224%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23FFF%22 d=%22M15.41,16.58L10.83,12L15.41,7.41L14,6L8,12L14,18L15.41,16.58Z%22/%3E%3C/svg%3E");
	color: #FFF;
}
</style>
