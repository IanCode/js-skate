var map = L.map('mapid', {
	center: [20.0, 5.0],
	minZoom: 2,
	zoom: 2
});

L.titleLayer('http://{s}.title.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
	domains: ['a','b','c']
}).addTo (map);