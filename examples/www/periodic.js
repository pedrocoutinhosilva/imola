
function fromHTML(html, trim = true) {
  html = html.toString()
    .replace(/&lt;/g , '<')
    .replace(/&gt;/g , '>')
    .replace(/&quot;/g , '\"')
    .replace(/&#39;/g , '\'')
    .replace(/&amp;/g , '&')

  // Process the HTML string.
  html = trim ? html : html.trim();
  if (!html) return null;

  // Then set up a new template element.
  const template = document.createElement('template');
  template.innerHTML = html;
  const result = template.content.children;

  // Then return either an HTMLElement or HTMLCollection,
  // based on whether the input HTML had one or more roots.
  if (result.length === 1) return result[0];
  return result;
}

$( document ).ready(function() {
  tippy('.single-cell', {
    content(reference) {
      const symb = reference.getAttribute('data-symb');
      const numb = reference.getAttribute('data-numb');
      const name = reference.getAttribute('data-name');
      const mass = reference.getAttribute('data-mass');
      const type = reference.getAttribute('data-type');
      const discoverer = reference.getAttribute('data-discoverer');
      const year = reference.getAttribute('data-year');
      const color = reference.getAttribute('data-color');

      let discovery = `<div>Discovered: ${discoverer} - ${year}</div>`
      if (discoverer == '') {
        discovery = `<div>Discovered: ${year}</div>`;
        if (year == '') {
          discovery = '';
        }
      }
      if (year == '') {
        discovery = `<div>Discovered: ${discoverer}</div>`;
        if (discoverer == '') {
          discovery = '';
        }
      }

      const template = `
        <div class = style='background: ${color}; padding: 2rem;'>
          <div>Atomic Number: ${numb}</div>
          <div>Atomic Symbol: ${symb}</div>
          <div>Element Name: ${name}</div>
          <div>Atomic Mass: ${mass}</div>
          <div>Element Type: ${type}</div>
          ${discovery}
        </div>
      `;

      return fromHTML(template);
    },
    allowHTML: true
  });
});