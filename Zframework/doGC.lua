local gc=love.graphics
local cmds={
	origin="origin",
	move="translate",
	scale="scale",
	rotate="rotate",
	clear="clear",

	setCL="setColor",
	setCM="setColorMask",
	setLW="setLineWidth",
	setLS="setLineStyle",
	setLJ="setLineJoin",

	setFT=function(...)setFont(...)end,
	dText="print",
	mText=function(...)ADRAW.str(...)end,
	mDraw=function(...)ADRAW.draw(...)end,

	draw="draw",
	dLine="line",
	fRect=function(...)gc.rectangle("fill",...)end,
	dRect=function(...)gc.rectangle("line",...)end,
	fCirc=function(...)gc.circle("fill",...)end,
	dCirc=function(...)gc.circle("line",...)end,
	fPoly=function(...)gc.polygon("fill",...)end,
	dPoly=function(...)gc.polygon("line",...)end,

	dPie=function(...)gc.arc("line",...)end,
	dArc=function(...)gc.arc("line","open",...)end,
	dBow=function(...)gc.arc("line","closed",...)end,
	fPie=function(...)gc.arc("fill",...)end,
	fArc=function(...)gc.arc("fill","open",...)end,
	fBow=function(...)gc.arc("fill","closed",...)end,
}
return function(L)
	gc.push()
		local canvas=gc.newCanvas(L[1],L[2])
		gc.setCanvas(canvas)
			gc.origin()
			gc.setColor(1,1,1)
			gc.setLineWidth(1)
			for i=3,#L do
				local cmd=cmds[L[i][1]]
				if type(cmd)=="string"then
					gc[cmd](unpack(L[i],2))
				elseif cmd then
					cmd(unpack(L[i],2))
				else
					error("No gc command: "..(L[i][1]or"[nil]"))
				end
			end
		gc.setCanvas()
	gc.pop()
	return canvas
end