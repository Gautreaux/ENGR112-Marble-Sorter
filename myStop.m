%stop all the motors, leave them in coast
if(exist('revolver'))
    stop(revolver)
end
if(exist('retreiver'))
    stop(retreiver)
end
if(exist('dispenser'))
    stop(dispenser)
end
if(exist('barcode'))
    stop(barcode)
end