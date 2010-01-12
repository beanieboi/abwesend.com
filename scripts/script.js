window.addEvent('domready', function() {
var myAccordion = new Accordion($('maincol'), 'h2.contentheader', 'div.content', {
opacity:true,
display: -1,
duration: 300,
alwaysHide: true,

		onActive: function(contentheader, content){
			contentheader.setStyle('font-weight', 'bold');
		},
		onBackground: function(contentheader, content){
			contentheader.setStyle('font-weight', 'bold');
		}
});
});