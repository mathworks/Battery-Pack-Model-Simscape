classdef batteryCoolingSystem < int32
% Battery abstraction selection definition.
    
% Copyright 2020-2023 The MathWorks, Inc.
    enumeration
        none        (1)
        thermalPort (2)
    end

    methods(Static)
        function map = displayText()
            map = containers.Map;
            map('none') = 'None';
            map('thermalPort') = 'Active';
        end
    end
end

