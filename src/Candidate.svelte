<script>
	import { filter } from './stores.js';
	import { scale, slide } from 'svelte/transition';

	export let poll;
	export let candidateid;
	export let name;
	export let gender;
	export let bio;
	export let instagram;
	export let facebook;
	export let linkedin;
	export let twitter;
	export let femaleIndex = false;
	let expand = false;
	$: male = gender == 'm';
	$: female = gender == 'v';

</script>

<div class="candidate" data-candidateid={candidateid} data-poll={poll} class:expand class:male class:female class:filter={$filter} tabindex="{!male || !$filter ? 0 : -1}" role="button" on:click={() => {if (!male || !$filter) expand = !expand}}>
	<div class="number">{candidateid}</div>
	<span class="name">{name}</span>
	<span class="tip">
	{#if candidateid <= poll}
	<span>tip</span>
	{/if}
	</span>
	<div class="chevron"></div>
</div>
{#if expand}
<div class="more" transition:slide>
	{#if bio}
		<a href="{bio}" target="_blank" rel="noopener noreferer" class="bio" role="button" aria-label="Biografie">Biografie</a>
	{:else}
		<span class="bio" aria-label="Bio">Biografie</span>
	{/if}
	{#if facebook}
		<a href="{facebook}" target="_blank" rel="noopener noreferer" class="facebook" role="button" aria-label="Facebook">Facebook</a>
	{:else}
		<span class="facebook" aria-label="Facebook"></span>
	{/if}
	{#if instagram}
		<a href="{instagram}" target="_blank" rel="noopener noreferer" class="instagram" role="button" aria-label="Instagram">Instagram</a>
	{:else}
		<span class="instagram" aria-label="Instagram"></span>
	{/if}
	{#if linkedin}
		<a href="{linkedin}" target="_blank" rel="noopener noreferer" class="linkedin" role="button" aria-label="LinkedIn">LinkedIn</a>
	{:else}
		<span class="linkedin" aria-label="LinkedIn"></span>
	{/if}
	{#if twitter}
		<a href="{twitter}" target="_blank" rel="noopener noreferer" class="twitter" role="button" aria-label="Twitter">Twitter</a>
	{:else}
		<span class="twitter" aria-label="Twitter"></span>
	{/if}
</div>
{/if}

<style>
.candidate {
	color: #dce9ef;
	background-color: #fff;
	margin-bottom: 0.3rem;
	padding: 0.5rem 1rem 0.5rem 0;
	cursor: pointer;
	transition: all ease-in-out 0.3s;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	position: relative;
	font-family: "acumin-pro", sans-serif;
	font-weight: 600;
	font-size: 22px;
	line-height: 20px;
	display: inline-grid;
	grid-template-columns: 30px min-content auto 30px;
	grid-gap: 1rem;
	width: 100%;
}

.female {
	color: #000;
}
span.name:before {
	content: '';
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
	background: linear-gradient(90deg, rgba(255,255,255,0) 60%, rgba(255,255,255,1));
}
.tip {
	line-height: 28px;
	display: none;
  align-items: center;
	font-size: 22px;
	line-height: 22px;
}
.female .tip {
	display: flex;
}
.tip span {
	color: #fff;
	background: #E88D69;
	border-radius: 5px;
	padding: 3px;
}
.name {
	line-height: 28px;
	display: flex;
  align-items: center;
}
.chevron {
	display: none;
  align-items: center;
	width: 26px;
	height: 26px;
	border: 1px solid #5098AB;
	/* chevron-right */
	background: transparent right 0 top 0 no-repeat url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%235098AB%22 d=%22M8.59,16.58L13.17,12L8.59,7.41L10,6L16,12L10,18L8.59,16.58Z%22/%3E%3C/svg%3E");
	z-index: 2;
}

.candidate:hover {
	color: #5098AB;
}

.candidate:hover > .chevron {
	background: #5098AB;
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23FFF%22 d=%22M8.59,16.58L13.17,12L8.59,7.41L10,6L16,12L10,18L8.59,16.58Z%22/%3E%3C/svg%3E");

}
.candidate.expand > .chevron {
	/* chevron-up */
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23CCC%22 d=%22M7.41,15.41L12,10.83L16.59,15.41L18,14L12,8L6,14L7.41,15.41Z%22/%3E%3C/svg%3E");
}
.candidate.expand:hover > .chevron {
	/* chevron-up */
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22%3E%3Cpath fill=%22%23FFF%22 d=%22M7.41,15.41L12,10.83L16.59,15.41L18,14L12,8L6,14L7.41,15.41Z%22/%3E%3C/svg%3E");
}
.number {
	display: inline-block;
	width: 1.8rem;
	height: 1.8rem;
	text-align: center;
	background-size: contain;
	vertical-align: bottom;
	/*vertical-align: middle;*/
	transition: all ease-in-out 0.3s;
	margin-right: 1rem;
	width: 26px;
	height: 26px;
	border-radius: 50%;
	border: 1px solid transparent;
}
.candidate:hover > .number {
	color: #fff;
	background: #5098AB;
	border: 1px solid transparent;
}
.female .chevron {
	display: flex;
}
.male .number {
	/*color: #FFF;*/
	border: 1px solid transparent;
	background-size: contain;
}
.female .number {
	border: 1px solid #000;
	background-size: contain;
}
.more {
	text-align: right;
	padding: 0.5rem 0;
}
.more > span, .more > a {
	display: inline-block;
	width: 2rem;
	height: 2rem;
	text-decoration: none;
	background-size: contain;
 	background-position: center right;
 	background-repeat: no-repeat;
 	margin-left: 1rem;
}
.bio {
	font-family: "acumin-pro-extra-condensed", Sans-serif;
	font-weight: 800;
	font-size: 22px;
}
span.bio {
	width: 4rem !important;
	text-align: left;
	vertical-align: top;
	line-height: 2rem;
	color: #CCC;
}
a.bio {
	width: 4rem !important;
	text-align: left;
	vertical-align: top;
	line-height: 2rem;
	color: #5098AB;
}
span.facebook {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%23CCC%22 d=%22M426.8 64H85.2C73.5 64 64 73.5 64 85.2v341.6c0 11.7 9.5 21.2 21.2 21.2H256V296h-45.9v-56H256v-41.4c0-49.6 34.4-76.6 78.7-76.6 21.2 0 44 1.6 49.3 2.3v51.8h-35.3c-24.1 0-28.7 11.4-28.7 28.2V240h57.4l-7.5 56H320v152h106.8c11.7 0 21.2-9.5 21.2-21.2V85.2c0-11.7-9.5-21.2-21.2-21.2z%22/%3E%3C/svg%3E");
}
a.facebook {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%235098AB%22 d=%22M426.8 64H85.2C73.5 64 64 73.5 64 85.2v341.6c0 11.7 9.5 21.2 21.2 21.2H256V296h-45.9v-56H256v-41.4c0-49.6 34.4-76.6 78.7-76.6 21.2 0 44 1.6 49.3 2.3v51.8h-35.3c-24.1 0-28.7 11.4-28.7 28.2V240h57.4l-7.5 56H320v152h106.8c11.7 0 21.2-9.5 21.2-21.2V85.2c0-11.7-9.5-21.2-21.2-21.2z%22/%3E%3C/svg%3E");
}
span.instagram {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%23CCC%22 d=%22M336 96c21.2 0 41.3 8.4 56.5 23.5S416 154.8 416 176v160c0 21.2-8.4 41.3-23.5 56.5S357.2 416 336 416H176c-21.2 0-41.3-8.4-56.5-23.5S96 357.2 96 336V176c0-21.2 8.4-41.3 23.5-56.5S154.8 96 176 96h160m0-32H176c-61.6 0-112 50.4-112 112v160c0 61.6 50.4 112 112 112h160c61.6 0 112-50.4 112-112V176c0-61.6-50.4-112-112-112z%22/%3E%3Cpath fill=%22%23CCC%22 d=%22M360 176c-13.3 0-24-10.7-24-24s10.7-24 24-24c13.2 0 24 10.7 24 24s-10.8 24-24 24zM256 192c35.3 0 64 28.7 64 64s-28.7 64-64 64-64-28.7-64-64 28.7-64 64-64m0-32c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96z%22/%3E%3C/svg%3E");
}
a.instagram {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%235098AB%22 d=%22M336 96c21.2 0 41.3 8.4 56.5 23.5S416 154.8 416 176v160c0 21.2-8.4 41.3-23.5 56.5S357.2 416 336 416H176c-21.2 0-41.3-8.4-56.5-23.5S96 357.2 96 336V176c0-21.2 8.4-41.3 23.5-56.5S154.8 96 176 96h160m0-32H176c-61.6 0-112 50.4-112 112v160c0 61.6 50.4 112 112 112h160c61.6 0 112-50.4 112-112V176c0-61.6-50.4-112-112-112z%22/%3E%3Cpath fill=%22%235098AB%22 d=%22M360 176c-13.3 0-24-10.7-24-24s10.7-24 24-24c13.2 0 24 10.7 24 24s-10.8 24-24 24zM256 192c35.3 0 64 28.7 64 64s-28.7 64-64 64-64-28.7-64-64 28.7-64 64-64m0-32c-53 0-96 43-96 96s43 96 96 96 96-43 96-96-43-96-96-96z%22/%3E%3C/svg%3E");
}
span.linkedin {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%23CCC%22 d=%22M417.2 64H96.8C79.3 64 64 76.6 64 93.9V415c0 17.4 15.3 32.9 32.8 32.9h320.3c17.6 0 30.8-15.6 30.8-32.9V93.9C448 76.6 434.7 64 417.2 64zM183 384h-55V213h55v171zm-25.6-197h-.4c-17.6 0-29-13.1-29-29.5 0-16.7 11.7-29.5 29.7-29.5s29 12.7 29.4 29.5c0 16.4-11.4 29.5-29.7 29.5zM384 384h-55v-93.5c0-22.4-8-37.7-27.9-37.7-15.2 0-24.2 10.3-28.2 20.3-1.5 3.6-1.9 8.5-1.9 13.5V384h-55V213h55v23.8c8-11.4 20.5-27.8 49.6-27.8 36.1 0 63.4 23.8 63.4 75.1V384z%22/%3E%3C/svg%3E");
}
a.linkedin {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%235098AB%22 d=%22M417.2 64H96.8C79.3 64 64 76.6 64 93.9V415c0 17.4 15.3 32.9 32.8 32.9h320.3c17.6 0 30.8-15.6 30.8-32.9V93.9C448 76.6 434.7 64 417.2 64zM183 384h-55V213h55v171zm-25.6-197h-.4c-17.6 0-29-13.1-29-29.5 0-16.7 11.7-29.5 29.7-29.5s29 12.7 29.4 29.5c0 16.4-11.4 29.5-29.7 29.5zM384 384h-55v-93.5c0-22.4-8-37.7-27.9-37.7-15.2 0-24.2 10.3-28.2 20.3-1.5 3.6-1.9 8.5-1.9 13.5V384h-55V213h55v23.8c8-11.4 20.5-27.8 49.6-27.8 36.1 0 63.4 23.8 63.4 75.1V384z%22/%3E%3C/svg%3E");
}
span.twitter {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%23CCC%22 d=%22M492 109.5c-17.4 7.7-36 12.9-55.6 15.3 20-12 35.4-31 42.6-53.6-18.7 11.1-39.4 19.2-61.5 23.5C399.8 75.8 374.6 64 346.8 64c-53.5 0-96.8 43.4-96.8 96.9 0 7.6.8 15 2.5 22.1-80.5-4-151.9-42.6-199.6-101.3-8.3 14.3-13.1 31-13.1 48.7 0 33.6 17.2 63.3 43.2 80.7-16-.4-31-4.8-44-12.1v1.2c0 47 33.4 86.1 77.7 95-8.1 2.2-16.7 3.4-25.5 3.4-6.2 0-12.3-.6-18.2-1.8 12.3 38.5 48.1 66.5 90.5 67.3-33.1 26-74.9 41.5-120.3 41.5-7.8 0-15.5-.5-23.1-1.4C62.8 432 113.7 448 168.3 448 346.6 448 444 300.3 444 172.2c0-4.2-.1-8.4-.3-12.5C462.6 146 479 129 492 109.5z%22/%3E%3C/svg%3E");
}
a.twitter {
	background-image: url("data:image/svg+xml,%3Csvg xmlns=%22http%3A//www.w3.org/2000/svg%22 viewBox=%220 0 512 512%22%3E%3Cpath fill=%22%235098AB%22 d=%22M492 109.5c-17.4 7.7-36 12.9-55.6 15.3 20-12 35.4-31 42.6-53.6-18.7 11.1-39.4 19.2-61.5 23.5C399.8 75.8 374.6 64 346.8 64c-53.5 0-96.8 43.4-96.8 96.9 0 7.6.8 15 2.5 22.1-80.5-4-151.9-42.6-199.6-101.3-8.3 14.3-13.1 31-13.1 48.7 0 33.6 17.2 63.3 43.2 80.7-16-.4-31-4.8-44-12.1v1.2c0 47 33.4 86.1 77.7 95-8.1 2.2-16.7 3.4-25.5 3.4-6.2 0-12.3-.6-18.2-1.8 12.3 38.5 48.1 66.5 90.5 67.3-33.1 26-74.9 41.5-120.3 41.5-7.8 0-15.5-.5-23.1-1.4C62.8 432 113.7 448 168.3 448 346.6 448 444 300.3 444 172.2c0-4.2-.1-8.4-.3-12.5C462.6 146 479 129 492 109.5z%22/%3E%3C/svg%3E");
}
.more a {
	transition: all ease-in-out 0.3s;
	cursor: pointer;
}
.more a:hover {
	transform: scale(1.4);
}
:global(li.save .candidate.female .checkmark) {
	background-image: url('images/stemopeenvrouw-gray.png');
}
:global(li:not(.save) .candidate.female .checkmark) {
	background-image: url('images/stemopeenvrouw.png');
}
a.instagram,a.facebook,a.twitter,a.linkedin {
	font-size: 0;
	color: transparent;
	overflow: hidden;
	vertical-align: top;
	line-height: 2rem;
}
</style>
