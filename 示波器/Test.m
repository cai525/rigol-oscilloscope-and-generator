classdef Test
    %TEST �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        Property1
    end
    
    methods
        function obj = Test(in)
            %TEST ��������ʵ��
            %   �˴���ʾ��ϸ˵��
            obj.Property1 = in;
        end
        
        function [obj,outputArg] = method1(obj ,inputArg)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   �˴���ʾ��ϸ˵��
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

  Test - ����:

    Property1: 3

b=a. method1(8)

b = 

  Test - ����:

    Property1: 8
���˵����obj����Ϊֱ�ӵķ��ز��������Ǽ�ӷ���
%}
