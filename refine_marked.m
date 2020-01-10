function [EToVfine, VXfine] = refine_marked(EToVcoarse, VXcoarse, idxMarked)
    
    VXfine = zeros(1, size(VXcoarse, 1) + length(idxMarked));
    EToVfine = zeros(size(EToVcoarse, 1) + length(idxMarked), 2);
    EToVfine(:,1) = 1:size(EToVfine,1);
    EToVfine(:,2) = 2:size(EToVfine,1)+1;

    c = 1;
    for i = 1:length(EToVcoarse)
        VXfine(c) = VXcoarse( EToVcoarse(i,1) );

        if ismember(i, idxMarked)
           VXfine(c+1) =  VXcoarse(EToVcoarse(i,1)) ...
               + ( VXcoarse(EToVcoarse(i,2)) ...
               - VXcoarse(EToVcoarse(i,1)))/2;
           c = c + 1;
        end

        VXfine(c+1) = VXcoarse( EToVcoarse(i,2) );
        c = c + 1;
    end

end