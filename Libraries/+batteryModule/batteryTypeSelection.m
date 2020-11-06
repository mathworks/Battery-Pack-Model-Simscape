classdef batteryTypeSelection < int32
% Battery type selection definition.
%    
% Copyright 2020 The MathWorks, Inc.
% 
    enumeration
        Pouch              (1)
        Can                (2)
        CompactCylindrical (3)
        RegularCylindrical (4)
    end

    methods(Static)
        function map = displayText()
            map = containers.Map;
            map('Pouch') = 'Pouch';
            map('Can') = 'Can';
            map('CompactCylindrical') = 'Compact cylindrical';
            map('RegularCylindrical') = 'Regular cylindrical';
        end
    end
end

