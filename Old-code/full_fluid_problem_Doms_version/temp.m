clear 
load n477x768
plot((x),(hprime_data(1:n,8)-hprime_data(1,8)),'o-', ...
    (x),(hprime_data(1:n,2)-hprime_data(1,2)),'o-'...
    )
axis([0,0.045,0,0.18])