# Demo

![Demo](demo.gif)

# Embed

The application is made for embedding, having zero padding and communicating it's height to the parent instead of having an internal scrollbar.

Embed code:
```html
<iframe id="votingadviseapp" style="border: none; width: 0; min-width: 100%; height: 800px; overflow: hidden;" src="https://..."></iframe>
<script>
window.addEventListener("message", receiveMessage, false);
function receiveMessage(event) {
  if (event.origin !== "https://...")
    return;
  document.getElementById('votingadviseapp').style.height = event.data + 'px';
}
</script>
```
Note that an origin (`event.origin` or `config.targetOrigin`) includes a schema (`http://` or `https://`) a domain name and optional port number, but no path or trailing `/`!.

Make sure your URL to embed from equals the `config.targetOrigin` in `rollup.config.js`, which now is `https://stemopeenvrouw.com` for production.

Use `?lang=en` in the iframe embed url to switch to English.

# Install

Requirements: docker-compose, a public Google Sheet ID and Google API Key enebled for Google Sheets.

```bash
docker-compose up -d
```
This will start `import-build-cron` which will connect to Google Sheets to fetch new data, a sheet ID and API Key are needed to.

Note that list icons are loaded in `static/global.css` which will need a change on election time, together with the share text in `src/App.svelte` and also note we wrote only IE grid code for the first 16 items.

## Keys

Keys are inlined for the moment:

`static/index.html`: Typekit key with Industry font

`.google-sheets-id`: Google Sheet ID

`.google-api-key`: Google API Key

## Development
```bash
docker-compose -f docer-compose.yml -f docker-compose-dev.yml up -d
docker-compose -f docker-compose.yml -f docker-compose-dev.yml logs -f app
```
<s>And go to `http://localhost:5000/embedtest.html` (auto reloaded with new builds).</s>
Open the `index.html` in the `build` directory in your browser.Should auto-reload most of the time. If not, do `docker exec -it stemopeenvrow_import-build-cron_1 rollup -c`

# License

`src/icons/*` / Icons: MIT see [Ionicons](https://ionicons.com/)

`src/*` / Code: CC0

`static/*.js` / [document-register-element](https://github.com/WebReflection/document-register-element/): ISC License
ISC License

`static/images/logo/*` / Political list/party logos: No license.
Sources:

Vector from Wikipedia or party site: 50PLUS, CDA, De Groenen, GROENLINKS, PvdA, PvdD and SP.

Bitmap from party site: JEZUS LEEFT, Lijst15.

Personally extracted from PDF from party website: ChristenUnie-SGP, DENK, D66 (and changed color), PVV.

Personally traced: FvD (determined font to be Grandesign Neue Roman) and Volt.

`static/images/*` / images: Copyright by [Stem op een Vrouw](https://stemopeenvrouw.com/).
