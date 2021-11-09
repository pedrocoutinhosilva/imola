$( document ).ready(function() {
  const pattern = trianglify({
    width: window.innerWidth,
    height: window.innerHeight,
    xColors: 'BuPu'
  })

  // Serialize the SVG object to a String
  var m = new XMLSerializer().serializeToString(pattern.toSVG());

  // Perform the base64 encoding of the String
  var k = window.btoa(m);

  // Query the element to set the background image property
  var element = document.getElementById('backgroundWrapper');

  // Set the background image property, including the encoding type header
  element.style.backgroundImage = 'url(\"data:image/svg+xml;base64,' + k + '\")';
});
