function txt= vec2Text(vec)
len = length(vec);
txt = '[';
for i=1:len
    txt = sprintf(' %s %3.2f',txt,vec(i));
end
txt = sprintf('%s ]',txt);