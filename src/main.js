import App from './App.svelte';
import lists from '../stemopeenvrouw.json';

const app = new App({
	target: document.getElementById('votingadviseapp'),
	props: {
		lists: lists,
		english: document.location.search.indexOf('lang=en') > -1, // Poor mans multilanguage trick
	},
	intro: true, // This enables the in:scale on the party list icons on component creation
});

export default app;