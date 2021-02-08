<script>
import { scale } from 'svelte/transition';
import CandidateList from './CandidateList.svelte';

export let lists;
export let english = false;
let sharemore = false;

let showlist = false;
function show(list) {
	showlist = list;
	if (list && history.pushState) {
		history.pushState({}, english ? 'Step 2' : 'Stap 2', '');
	}
}
function popstate(event) {
	show(false);
}
const shareInfo = {
	title: english ? 'I vote for a woman' : 'Ik stem op een vrouw',
	text:  english ? 'I vote for a woman, lower on the candidate list for the European Parliament elections on May 23. Look here for all eligible parties, candidates and election programs!' : 'Ik stem op een vrouw, lager op de lijst, bij de Europese Parlementsverkiezingen op 23 mei. Bekijk hier alle verkiesbare partijen, kandidaten en verkiezingsprogramma\'s!',
	url: english ? 'https://stemopeenvrouw.com/voting-advice/?lang=en' : 'https://stemopeenvrouw.com/stemtip/',
};
function share(event) {
	if (navigator.share) {
		navigator.share(shareInfo)
		.then(() => console.log('Successful share'))
		.catch(error => {console.log('Error sharing', error);sharemore = !sharemore;});
	} else {
		sharemore = !sharemore;
	}
}
let pageHeight;
$: {
	if (pageHeight && window.parent != window) {
		//console.log("Resize", pageHeight);
		window.parent.postMessage(pageHeight + 65, config.targetOrigin); // 65 for sharing button
	}
}
</script>

<svelte:window on:popstate={popstate} />

<div bind:offsetHeight={pageHeight} on:click={()=>sharemore=false}>
	{#if !showlist }
		<div class="electiongrid">
		{#each lists as list, i (list.listid) }
			<button class="listselect" on:click={() => show(list)}><div in:scale={{delay: 200 + i * 50}} class="logo list_{list.listid}" role="button" aria-label="{list.listname}"></div></button>
		{/each}
		</div>
	{:else}
		<div>
			<CandidateList {...showlist} {english} on:click={() => show(false)}/>
		</div>
	{/if}
	<div class="share" on:mouseover={()=>sharemore=false}><div on:click|stopPropagation on:mouseover|stopPropagation class:sharemore class="wrapper">{#if sharemore}
		<a target="_blank" rel="noopener noreferer" href="mailto:?subject={encodeURIComponent(shareInfo.title)}&body={encodeURIComponent(shareInfo.text + "\r\n" + shareInfo.url)}" role="button" aria-label="Email" class="email">Email</a>
		<a target="_blank" rel="noopener noreferer" href="https://www.facebook.com/sharer.php?u={encodeURIComponent(shareInfo.url)}&t={encodeURIComponent(shareInfo.text)}" role="button" aria-label="Facebook" class="facebook">Facebook</a>
		<a target="_blank" rel="noopener noreferer" href="https://twitter.com/share?url={encodeURIComponent(shareInfo.url)}&text={encodeURIComponent(shareInfo.text)}" role="button" aria-label="Twitter" class="twitter">Twitter</a>
		<a target="_blank" rel="noopener noreferer" href="https://www.linkedin.com/shareArticle?mini=true&url={encodeURIComponent(shareInfo.url)}&title={encodeURIComponent(shareInfo.title)}&summary={encodeURIComponent(shareInfo.text)}" role="button" aria-label="LinkedIn" class="linkedin">LinkedIn</a>
		<a target="_blank" rel="noopener noreferer" href="whatsapp://send?text={encodeURIComponent(shareInfo.text + " " + shareInfo.url)}" role="button" aria-label="WhatsApp" class="whatsapp">WhatsApp</a>
	{/if}<button  role="button" class="main" on:mouseover|stopPropagation={()=>sharemore=!window.navigator.share} on:click={share}>{english ? "Share" : "Delen"}!</button></div></div>
</div>

<style>
.electiongrid {
	padding: 0.4rem 0;
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(5.6rem, 1fr));
	-ms-grid-columns: minmax(5.6rem, 1fr) minmax(5.6rem, 1fr) minmax(5.6rem, 1fr) minmax(5.6rem, 1fr);
}
.listselect:nth-child( 1) {-ms-grid-row: 1;-ms-grid-column: 1;}
.listselect:nth-child( 2) {-ms-grid-row: 1;-ms-grid-column: 2;}
.listselect:nth-child( 3) {-ms-grid-row: 1;-ms-grid-column: 3;}
.listselect:nth-child( 4) {-ms-grid-row: 1;-ms-grid-column: 4;}
.listselect:nth-child( 5) {-ms-grid-row: 2;-ms-grid-column: 1;}
.listselect:nth-child( 6) {-ms-grid-row: 2;-ms-grid-column: 2;}
.listselect:nth-child( 7) {-ms-grid-row: 2;-ms-grid-column: 3;}
.listselect:nth-child( 8) {-ms-grid-row: 2;-ms-grid-column: 4;}
.listselect:nth-child( 9) {-ms-grid-row: 3;-ms-grid-column: 1;}
.listselect:nth-child(10) {-ms-grid-row: 3;-ms-grid-column: 2;}
.listselect:nth-child(11) {-ms-grid-row: 3;-ms-grid-column: 3;}
.listselect:nth-child(12) {-ms-grid-row: 3;-ms-grid-column: 4;}
.listselect:nth-child(13) {-ms-grid-row: 4;-ms-grid-column: 1;}
.listselect:nth-child(14) {-ms-grid-row: 4;-ms-grid-column: 2;}
.listselect:nth-child(15) {-ms-grid-row: 4;-ms-grid-column: 3;}
.listselect:nth-child(16) {-ms-grid-row: 4;-ms-grid-column: 4;}
.listselect {
	background: none;
	border: none;
	appearance: none;
	-webkit-tap-highlight-color: transparent;
	min-height: 4.6rem;
	margin: 0;
	padding: 0.7rem;
	display: block;
	box-sizing: border-box;
	transition: all ease-in-out 0.3s;
	cursor: pointer;
}
.listselect:hover {
	transform: scale(1.4);
}
.logo {
	height: 100%;
	min-height: 3.2rem;
	background-size: contain;
	background-repeat: no-repeat;
	background-position: center center;
}
.share {
	position: fixed;
	bottom: 0;
	right: 0;
	padding: 1.4rem;
}
.share > div {
	transition: all ease-in-out 0.3s;
	border-radius: 5rem 20rem 20rem 5rem;
}
.share > div.sharemore {
	background-color: #FFF;
}
.share button.main {
	font-weight: bolder;
	background-color: #FFF;
	border-radius: 50%;
	transform: rotate(-20deg);
	font-family: inherit;
	cursor: pointer;
	height: 3.5rem;
	width: 3.5rem;
	text-align: center;
	line-height: 2rem;
	margin: 0;
	padding: 0;
	border: 3px solid #ee956a;
	box-shadow: 0 0 0 3px #4e96a9;
	transition: all ease-in-out 0.3s;
	-webkit-tap-highlight-color: transparent;
	appearance: none;
	z-index: 3;
}
.share button.main:hover, .sharemore button.main {
	transform: scale(1.4) rotate(20deg);
}
.share a {
	display: inline-block;
	width: 2rem;
	height: 2rem;
	vertical-align: middle;
	font-size: 0;
	color: transparent;
	overflow: hidden;
	text-decoration: none;
	background-size: contain;
	background-position: center center;
	background-repeat: no-repeat;
	margin-left: 0.5rem;
}
a.email {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%234e96a9%22 d=%22M437.332 80H74.668C51.199 80 32 99.198 32 122.667v266.666C32 412.802 51.199 432 74.668 432h362.664C460.801 432 480 412.802 480 389.333V122.667C480 99.198 460.801 80 437.332 80zM432 170.667L256 288 80 170.667V128l176 117.333L432 128v42.667z%22/%3E%3C/svg%3E");
}
a.facebook {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%234e96a9%22 d=%22M426.8 64H85.2C73.5 64 64 73.5 64 85.2v341.6c0 11.7 9.5 21.2 21.2 21.2H256V296h-45.9v-56H256v-41.4c0-49.6 34.4-76.6 78.7-76.6 21.2 0 44 1.6 49.3 2.3v51.8h-35.3c-24.1 0-28.7 11.4-28.7 28.2V240h57.4l-7.5 56H320v152h106.8c11.7 0 21.2-9.5 21.2-21.2V85.2c0-11.7-9.5-21.2-21.2-21.2z%22/%3E%3C/svg%3E");
}
a.linkedin {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%234e96a9%22 d=%22M417.2 64H96.8C79.3 64 64 76.6 64 93.9V415c0 17.4 15.3 32.9 32.8 32.9h320.3c17.6 0 30.8-15.6 30.8-32.9V93.9C448 76.6 434.7 64 417.2 64zM183 384h-55V213h55v171zm-25.6-197h-.4c-17.6 0-29-13.1-29-29.5 0-16.7 11.7-29.5 29.7-29.5s29 12.7 29.4 29.5c0 16.4-11.4 29.5-29.7 29.5zM384 384h-55v-93.5c0-22.4-8-37.7-27.9-37.7-15.2 0-24.2 10.3-28.2 20.3-1.5 3.6-1.9 8.5-1.9 13.5V384h-55V213h55v23.8c8-11.4 20.5-27.8 49.6-27.8 36.1 0 63.4 23.8 63.4 75.1V384z%22/%3E%3C/svg%3E");
}
a.twitter {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%234e96a9%22 d=%22M492 109.5c-17.4 7.7-36 12.9-55.6 15.3 20-12 35.4-31 42.6-53.6-18.7 11.1-39.4 19.2-61.5 23.5C399.8 75.8 374.6 64 346.8 64c-53.5 0-96.8 43.4-96.8 96.9 0 7.6.8 15 2.5 22.1-80.5-4-151.9-42.6-199.6-101.3-8.3 14.3-13.1 31-13.1 48.7 0 33.6 17.2 63.3 43.2 80.7-16-.4-31-4.8-44-12.1v1.2c0 47 33.4 86.1 77.7 95-8.1 2.2-16.7 3.4-25.5 3.4-6.2 0-12.3-.6-18.2-1.8 12.3 38.5 48.1 66.5 90.5 67.3-33.1 26-74.9 41.5-120.3 41.5-7.8 0-15.5-.5-23.1-1.4C62.8 432 113.7 448 168.3 448 346.6 448 444 300.3 444 172.2c0-4.2-.1-8.4-.3-12.5C462.6 146 479 129 492 109.5z%22/%3E%3C/svg%3E");
}
a.whatsapp {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%234e96a9%22 d=%22M260.062 32C138.605 32 40.134 129.701 40.134 250.232c0 41.23 11.532 79.79 31.559 112.687L32 480l121.764-38.682c31.508 17.285 67.745 27.146 106.298 27.146C381.535 468.464 480 370.749 480 250.232 480 129.701 381.535 32 260.062 32zm109.362 301.11c-5.174 12.827-28.574 24.533-38.899 25.072-10.314.547-10.608 7.994-66.84-16.434-56.225-24.434-90.052-83.844-92.719-87.67-2.669-3.812-21.78-31.047-20.749-58.455 1.038-27.413 16.047-40.346 21.404-45.725 5.351-5.387 11.486-6.352 15.232-6.413 4.428-.072 7.296-.132 10.573-.011 3.274.124 8.192-.685 12.45 10.639 4.256 11.323 14.443 39.153 15.746 41.989 1.302 2.839 2.108 6.126.102 9.771-2.012 3.653-3.042 5.935-5.961 9.083-2.935 3.148-6.174 7.042-8.792 9.449-2.92 2.665-5.97 5.572-2.9 11.269 3.068 5.693 13.653 24.356 29.779 39.736 20.725 19.771 38.598 26.329 44.098 29.317 5.515 3.004 8.806 2.67 12.226-.929 3.404-3.599 14.639-15.746 18.596-21.169 3.955-5.438 7.661-4.373 12.742-2.329 5.078 2.052 32.157 16.556 37.673 19.551 5.51 2.989 9.193 4.529 10.51 6.9 1.317 2.38.901 13.531-4.271 26.359z%22/%3E%3C/svg%3E");
	margin-right: 1.1rem;
}
.share a {
	transition: all ease-in-out 0.3s;
	cursor: pointer;
}
.share a:hover {
	transform: scale(1.4);
}

@media (min-width: 384px) {
	.electiongrid {
		padding: 0.15rem;
	}
}
@media (min-width: 768px) {
	.electiongrid {
		padding: 0.8rem;
		grid-template-columns: repeat(auto-fill, minmax(4.56rem, 1fr));
		-ms-grid-columns: minmax(5.6rem, 1fr) minmax(5.6rem, 1fr) minmax(5.6rem, 1fr) minmax(5.6rem, 1fr) minmax(5.6rem, 1fr) minmax(5.6rem, 1fr);
	}
	.listselect {
		min-height: 6.14rem;
	}
	.logo {
		min-height: 4.74rem;
	}
	.listselect:nth-child( 1) {-ms-grid-row: 1;-ms-grid-column: 1;}
	.listselect:nth-child( 2) {-ms-grid-row: 1;-ms-grid-column: 2;}
	.listselect:nth-child( 3) {-ms-grid-row: 1;-ms-grid-column: 3;}
	.listselect:nth-child( 4) {-ms-grid-row: 1;-ms-grid-column: 4;}
	.listselect:nth-child( 5) {-ms-grid-row: 1;-ms-grid-column: 5;}
	.listselect:nth-child( 6) {-ms-grid-row: 1;-ms-grid-column: 6;}
	.listselect:nth-child( 7) {-ms-grid-row: 2;-ms-grid-column: 1;}
	.listselect:nth-child( 8) {-ms-grid-row: 2;-ms-grid-column: 2;}
	.listselect:nth-child( 9) {-ms-grid-row: 2;-ms-grid-column: 3;}
	.listselect:nth-child(10) {-ms-grid-row: 2;-ms-grid-column: 4;}
	.listselect:nth-child(11) {-ms-grid-row: 2;-ms-grid-column: 5;}
	.listselect:nth-child(12) {-ms-grid-row: 2;-ms-grid-column: 6;}
	.listselect:nth-child(13) {-ms-grid-row: 3;-ms-grid-column: 1;}
	.listselect:nth-child(14) {-ms-grid-row: 3;-ms-grid-column: 2;}
	.listselect:nth-child(15) {-ms-grid-row: 3;-ms-grid-column: 3;}
	.listselect:nth-child(16) {-ms-grid-row: 3;-ms-grid-column: 4;}
	.share a {
		margin-left: 1rem;
	}
}
</style>
