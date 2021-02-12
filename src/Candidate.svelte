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
	<div class="chevron"></div>
</div>
{#if expand}
<div class="more" transition:slide>
	{#if bio}
		<a href="{bio}" target="_blank" rel="noopener noreferer" class="bio" role="button" aria-label="Biografie">Bio</a>
	{:else}
		<span class="bio" aria-label="Bio">Bio</span>
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
	grid-template-columns: 30px auto 30px;
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
.name {
	font-size: 20px;
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
	width: 1rem;
	height: 1rem;
	padding: 0.5rem;
	background-size: 50% !important;
	border-radius: 50%;
	background-position: center !important;
	background-repeat: no-repeat !important;
	text-decoration: none;
	background-size: contain;
 	background-position: center right;
 	background-repeat: no-repeat;
 	margin-left: 1rem;
}
.more > span {
	color: white;
	background: #CCC;
}
.more > a {
	color: white;
	background: #5098AB;
}
.bio {
	font-family: "acumin-pro-extra-condensed", Sans-serif;
	font-weight: 800;
	font-size: 22px;
}
span.bio {
	width: 4rem !important;
	text-align: right;
	vertical-align: top;
	line-height: 1rem;
	color: #CCC;
	background: transparent;
	padding: 0.5rem;
}
a.bio {
	width: 4rem !important;
	text-align: right;
	vertical-align: top;
	line-height: 1rem;
	color: #5098AB;
	background: transparent;
	padding: 0.5rem;
}
span.facebook {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22facebook-f%22%20class%3D%22svg-inline--fa%20fa-facebook-f%20fa-w-10%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20320%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M279.14%20288l14.22-92.66h-88.91v-60.13c0-25.35%2012.42-50.06%2052.24-50.06h40.42V6.26S260.43%200%20225.36%200c-73.22%200-121.08%2044.38-121.08%20124.72v70.62H22.89V288h81.39v224h100.17V288z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
a.facebook {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22facebook-f%22%20class%3D%22svg-inline--fa%20fa-facebook-f%20fa-w-10%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20320%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M279.14%20288l14.22-92.66h-88.91v-60.13c0-25.35%2012.42-50.06%2052.24-50.06h40.42V6.26S260.43%200%20225.36%200c-73.22%200-121.08%2044.38-121.08%20124.72v70.62H22.89V288h81.39v224h100.17V288z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
span.instagram {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22instagram%22%20class%3D%22svg-inline--fa%20fa-instagram%20fa-w-14%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20448%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M224.1%20141c-63.6%200-114.9%2051.3-114.9%20114.9s51.3%20114.9%20114.9%20114.9S339%20319.5%20339%20255.9%20287.7%20141%20224.1%20141zm0%20189.6c-41.1%200-74.7-33.5-74.7-74.7s33.5-74.7%2074.7-74.7%2074.7%2033.5%2074.7%2074.7-33.6%2074.7-74.7%2074.7zm146.4-194.3c0%2014.9-12%2026.8-26.8%2026.8-14.9%200-26.8-12-26.8-26.8s12-26.8%2026.8-26.8%2026.8%2012%2026.8%2026.8zm76.1%2027.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9%200-35.8%201.7-67.6%209.9-93.9%2036.1s-34.4%2058-36.2%2093.9c-2.1%2037-2.1%20147.9%200%20184.9%201.7%2035.9%209.9%2067.7%2036.2%2093.9s58%2034.4%2093.9%2036.2c37%202.1%20147.9%202.1%20184.9%200%2035.9-1.7%2067.7-9.9%2093.9-36.2%2026.2-26.2%2034.4-58%2036.2-93.9%202.1-37%202.1-147.8%200-184.8zM398.8%20388c-7.8%2019.6-22.9%2034.7-42.6%2042.6-29.5%2011.7-99.5%209-132.1%209s-102.7%202.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7%209-132.1c7.8-19.6%2022.9-34.7%2042.6-42.6%2029.5-11.7%2099.5-9%20132.1-9s102.7-2.6%20132.1%209c19.6%207.8%2034.7%2022.9%2042.6%2042.6%2011.7%2029.5%209%2099.5%209%20132.1s2.7%20102.7-9%20132.1z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
a.instagram {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22instagram%22%20class%3D%22svg-inline--fa%20fa-instagram%20fa-w-14%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20448%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M224.1%20141c-63.6%200-114.9%2051.3-114.9%20114.9s51.3%20114.9%20114.9%20114.9S339%20319.5%20339%20255.9%20287.7%20141%20224.1%20141zm0%20189.6c-41.1%200-74.7-33.5-74.7-74.7s33.5-74.7%2074.7-74.7%2074.7%2033.5%2074.7%2074.7-33.6%2074.7-74.7%2074.7zm146.4-194.3c0%2014.9-12%2026.8-26.8%2026.8-14.9%200-26.8-12-26.8-26.8s12-26.8%2026.8-26.8%2026.8%2012%2026.8%2026.8zm76.1%2027.2c-1.7-35.9-9.9-67.7-36.2-93.9-26.2-26.2-58-34.4-93.9-36.2-37-2.1-147.9-2.1-184.9%200-35.8%201.7-67.6%209.9-93.9%2036.1s-34.4%2058-36.2%2093.9c-2.1%2037-2.1%20147.9%200%20184.9%201.7%2035.9%209.9%2067.7%2036.2%2093.9s58%2034.4%2093.9%2036.2c37%202.1%20147.9%202.1%20184.9%200%2035.9-1.7%2067.7-9.9%2093.9-36.2%2026.2-26.2%2034.4-58%2036.2-93.9%202.1-37%202.1-147.8%200-184.8zM398.8%20388c-7.8%2019.6-22.9%2034.7-42.6%2042.6-29.5%2011.7-99.5%209-132.1%209s-102.7%202.6-132.1-9c-19.6-7.8-34.7-22.9-42.6-42.6-11.7-29.5-9-99.5-9-132.1s-2.6-102.7%209-132.1c7.8-19.6%2022.9-34.7%2042.6-42.6%2029.5-11.7%2099.5-9%20132.1-9s102.7-2.6%20132.1%209c19.6%207.8%2034.7%2022.9%2042.6%2042.6%2011.7%2029.5%209%2099.5%209%20132.1s2.7%20102.7-9%20132.1z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
span.linkedin {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22linkedin%22%20class%3D%22svg-inline--fa%20fa-linkedin%20fa-w-14%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20448%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M416%2032H31.9C14.3%2032%200%2046.5%200%2064.3v383.4C0%20465.5%2014.3%20480%2031.9%20480H416c17.6%200%2032-14.5%2032-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4%20416H69V202.2h66.5V416zm-33.2-243c-21.3%200-38.5-17.3-38.5-38.5S80.9%2096%20102.2%2096c21.2%200%2038.5%2017.3%2038.5%2038.5%200%2021.3-17.2%2038.5-38.5%2038.5zm282.1%20243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6%200-39.9%2027-39.9%2054.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8%2030.6-34.5%2062.9-34.5%2067.2%200%2079.7%2044.3%2079.7%20101.9V416z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
a.linkedin {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22linkedin%22%20class%3D%22svg-inline--fa%20fa-linkedin%20fa-w-14%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20448%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M416%2032H31.9C14.3%2032%200%2046.5%200%2064.3v383.4C0%20465.5%2014.3%20480%2031.9%20480H416c17.6%200%2032-14.5%2032-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4%20416H69V202.2h66.5V416zm-33.2-243c-21.3%200-38.5-17.3-38.5-38.5S80.9%2096%20102.2%2096c21.2%200%2038.5%2017.3%2038.5%2038.5%200%2021.3-17.2%2038.5-38.5%2038.5zm282.1%20243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6%200-39.9%2027-39.9%2054.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8%2030.6-34.5%2062.9-34.5%2067.2%200%2079.7%2044.3%2079.7%20101.9V416z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
span.twitter {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22twitter%22%20class%3D%22svg-inline--fa%20fa-twitter%20fa-w-16%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20512%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M459.37%20151.716c.325%204.548.325%209.097.325%2013.645%200%20138.72-105.583%20298.558-298.558%20298.558-59.452%200-114.68-17.219-161.137-47.106%208.447.974%2016.568%201.299%2025.34%201.299%2049.055%200%2094.213-16.568%20130.274-44.832-46.132-.975-84.792-31.188-98.112-72.772%206.498.974%2012.995%201.624%2019.818%201.624%209.421%200%2018.843-1.3%2027.614-3.573-48.081-9.747-84.143-51.98-84.143-102.985v-1.299c13.969%207.797%2030.214%2012.67%2047.431%2013.319-28.264-18.843-46.781-51.005-46.781-87.391%200-19.492%205.197-37.36%2014.294-52.954%2051.655%2063.675%20129.3%20105.258%20216.365%20109.807-1.624-7.797-2.599-15.918-2.599-24.04%200-57.828%2046.782-104.934%20104.934-104.934%2030.213%200%2057.502%2012.67%2076.67%2033.137%2023.715-4.548%2046.456-13.32%2066.599-25.34-7.798%2024.366-24.366%2044.833-46.132%2057.827%2021.117-2.273%2041.584-8.122%2060.426-16.243-14.292%2020.791-32.161%2039.308-52.628%2054.253z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
a.twitter {
	background-image: url("data:image/svg+xml,%3Csvg%20aria-hidden%3D%22true%22%20focusable%3D%22false%22%20data-prefix%3D%22fab%22%20data-icon%3D%22twitter%22%20class%3D%22svg-inline--fa%20fa-twitter%20fa-w-16%22%20role%3D%22img%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20512%20512%22%3E%3Cpath%20fill%3D%22%23FFF%22%20d%3D%22M459.37%20151.716c.325%204.548.325%209.097.325%2013.645%200%20138.72-105.583%20298.558-298.558%20298.558-59.452%200-114.68-17.219-161.137-47.106%208.447.974%2016.568%201.299%2025.34%201.299%2049.055%200%2094.213-16.568%20130.274-44.832-46.132-.975-84.792-31.188-98.112-72.772%206.498.974%2012.995%201.624%2019.818%201.624%209.421%200%2018.843-1.3%2027.614-3.573-48.081-9.747-84.143-51.98-84.143-102.985v-1.299c13.969%207.797%2030.214%2012.67%2047.431%2013.319-28.264-18.843-46.781-51.005-46.781-87.391%200-19.492%205.197-37.36%2014.294-52.954%2051.655%2063.675%20129.3%20105.258%20216.365%20109.807-1.624-7.797-2.599-15.918-2.599-24.04%200-57.828%2046.782-104.934%20104.934-104.934%2030.213%200%2057.502%2012.67%2076.67%2033.137%2023.715-4.548%2046.456-13.32%2066.599-25.34-7.798%2024.366-24.366%2044.833-46.132%2057.827%2021.117-2.273%2041.584-8.122%2060.426-16.243-14.292%2020.791-32.161%2039.308-52.628%2054.253z%22%3E%3C%2Fpath%3E%3C%2Fsvg%3E");
}
.more a {
	transition: all ease-in-out 0.3s;
	cursor: pointer;
}
.more a:hover {
	transform: scale(1.2);
}
:global(li.save .candidate.female .checkmark) {
	background-image: url('images/stemopeenvrouw-gray.png');
}
:global(li:not(.save) .candidate.female .checkmark) {
	background-image: url('images/stemopeenvrouw.png');
}
a.instagram,a.facebook,a.twitter,a.linkedin {
	font-size: 0;
	color: #FFF;
	overflow: hidden;
	vertical-align: top;
	line-height: 2rem;
}
</style>
