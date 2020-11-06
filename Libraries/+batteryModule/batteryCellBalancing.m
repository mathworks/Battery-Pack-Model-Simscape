classdef batteryCellBalancing < int32
% Battery type selection definition.
    
% Copyright 2020 The MathWorks, Inc.
    enumeration
        None              (1)
        Passive           (2)
    end

    methods(Static)
        function map = displayText()
            map = containers.Map;
            map('None') = 'None';
            map('Passive') = 'Passive';
        end
    end
end

