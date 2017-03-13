%random white noise generation to unvoiced frame
function wn=whitenoise(unvoicingInd)
wn=randn(180,numel(unvoicingInd));
end