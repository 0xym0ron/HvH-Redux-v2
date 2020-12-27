/*
	
	hvh: redux v2
	by 0xymoron
	
	killicon shit
	
*/

surface.CreateFont( "CSS", {

	font = "csd",
	size = ScreenScale( 26 ),
	antialias = true,

} )

for class, tab in next, HVH_CONFIG.Killicons do
	
	killicon.AddFont( class, tab.font, tab.id, tab.color )
	
end
