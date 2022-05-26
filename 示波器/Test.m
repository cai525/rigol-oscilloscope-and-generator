classdef Test
    %TEST 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        Property1
    end
    
    methods
        function obj = Test(in)
            %TEST 构造此类的实例
            %   此处显示详细说明
            obj.Property1 = in;
        end
        
        function [obj,outputArg] = method1(obj ,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            obj.Property1 = inputArg;
            outputArg = nargin;
           if nargin == 1
               fprintf('1');
           else
               fprintf('0')
           end
           nargin
        end
    end
end
%{
 a=Test(3)

a = 

  Test - 属性:

    Property1: 3

b=a. method1(8)

b = 

  Test - 属性:

    Property1: 8
结果说明：obj不作为直接的返回参数，而是间接返回
%}
