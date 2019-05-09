import { writable } from 'svelte/store';

export const filter = writable(0);

filter.set(true);