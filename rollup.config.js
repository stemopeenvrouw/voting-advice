import svelte from 'rollup-plugin-svelte';
import replace from '@rollup/plugin-replace';
import resolve from '@rollup/plugin-node-resolve';
import json from '@rollup/plugin-json';
import commonjs from '@rollup/plugin-commonjs';
import livereload from 'rollup-plugin-livereload';
import { terser } from 'rollup-plugin-terser';
import copy from "rollup-plugin-copy";
import babel from '@rollup/plugin-babel';
import postcss from 'rollup-plugin-postcss';
// import postcss from 'postcss';
// import postcssImport from 'postcss-import';
// import postcssPresetEnv from 'postcss-preset-env';
//import postcssSVG from 'postcss-svg';

const production = !process.env.ROLLUP_WATCH;

export default {
	input: 'src/main.js',
	output: {
		sourcemap: true,
		format: 'iife',
		name: 'app',
		file: 'build/votingadviseapp.js',
	},
	external: ['core-js'],
	plugins: [
		replace({
			'config.targetOrigin': JSON.stringify(production ? 'https://www.stemopeenvrouw.com' : 'http://localhost:5000'),
		}),
		svelte({
			dev: !production,
			emitCss: true,
			//legacy: production,
			// preprocess: {
			// 	style: ({ content, attributes }) => {
			// 		if (attributes.type !== 'text/postcss') {
			// 			return;
			// 		}
			// 		return new Promise((resolve, reject) => {
			// 			postcss([
			// 				postcssImport({
			// 					path: ["src"],
			// 				}),
			// 				postcssPresetEnv({
			// 					autoprefixer: { grid: true },
			// 				})
			// 			]).process(content, {
			// 				from: 'src',
			// 				map: {
			// 					inline: false,
			// 				},
			// 			}).then(result => {
			// 				resolve({
			// 				code: result.css.toString(),
			// 				map: result.map.toString(),
			// 				});
			// 			}).catch(err => reject(err));
			// 		});
			// 	},
			// },
			css: css => {
				css.write('build/votingadviseapp.css');
			},
		}),
		postcss({
      plugins: []
    }),
		resolve({
			browser: true,
			dedupe: ['svelte']
		}),
		json(),
		commonjs(),
		production && babel({
			extensions: ['.js', '.mjs', '.html', '.svelte'],
			babelHelpers: 'runtime',
			exclude: ['node_modules/@babel/**', 'node_modules/core-js/**'],
			plugins: [['@babel/transform-runtime', { regenerator: false, useESModules: true }]],
			presets: [
				['@babel/preset-env', {
					//targets: '> 0.25%, not op_mini all, not dead, IE 10-11',
					// https://browserl.ist/?q=%3E+0.25%25%2C+not+op_mini+all%2C+not+dead%2C+IE+10-11
					useBuiltIns: 'usage',
					corejs: 3,
					loose: true,
				}],
			],
		}),
		copy({
			targets: [{src: 'static/*', dest: 'build'}],
			verbose: true
		}),
		!production && livereload('build'),
		production && terser(),
	],
};
