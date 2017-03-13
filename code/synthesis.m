%decoder
%tenth order difference equation for unvoiced
function reconstructed=synthesis(impulse,wn,unvoicingInd,voicingInd,a)
%unvoiced
for i=1:numel(unvoicedInd)+numel(voicingInd) 
if find(unvocingInd==i)
    x=wn(:,i);
else x=impulse(:,i);
end
reconstructed(:,i)=filter(1,[1,-a(:,i)'],x);
end
end