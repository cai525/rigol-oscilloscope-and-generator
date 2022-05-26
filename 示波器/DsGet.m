classdef DsGet
    %DsGet: DS2020A的子类，作用是从外设取得参数 
    
    properties
        visGet 
        inputBufferSize = 4098;
        Fs = [];
    end
    
    methods
        function obj = DsGet(ds2020a)
            obj.visGet =  ds2020a.vis();
            obj.visGet.InputBufferSize = obj.inputBufferSize;
        end
        

        function [t,data]=ChanelDisp(obj,channelStr)
        %展示波形
        %输入：channelStr：{D0|D1|D2|D3|D4|D5|D6|D7|D8|D9|D10|D11|D12|D13|D14|D15|CHANnel1|CHANnel2|MATH}

            %选择通道
            fprintf(obj.visGet,  strcat(":waveform:source ", channelStr) );
            %设置读取方式
            fprintf(obj.visGet,":WAVeform:MODE NORM");  %普通读取：读取屏幕的值
            fprintf(obj.visGet,"WAV:FORM  ASCii");       %以ASCII码读取屏幕电压值
            %读取波形
            fprintf(obj.visGet, ':wav:data?');          %向缓存中写入数据
            %请求数据
            %[~,len]= fread(obj.visGet,obj.inputBufferSize,'char');  %从缓存中读数据
            %data = fscanf(obj.visGet,'*char'); 
            %b=cell2mat(textscan(data,'%f,'));
            raw = fscanf(obj.visGet,'*char');
            while(double(raw(end))~=10)
               raw =  [raw, fscanf(obj.visGet,'*char')];
            end
            b=cell2mat(textscan(raw,'%f,'));
            data = b(1:end-1);
            len = length(data);
            % 获取采样频率
            fprintf(obj.visGet,':ACQuire:SRATe?');
            fs = fscanf(obj.visGet);
            fs = str2double(fs);
            obj.Fs = num2str(fs);  
            %绘制图形           
                
            n = 1:length(data);
            t = n/fs;
            % data = data;
            dim = size(t);
            data = reshape(data,dim(1),dim(2));
        end
        

        function [img] = ScreenShot(obj,ColorInvert,filename) 
        %截图并保存
            if nargin < 3
                ColorInvert = 1;
            end            
            txHeader = 11;%9+2:原因见:DISP:DATA?文件关于TMC头的描述
            bitHeader = 54;
            pxBytes = 480*800*3;            
            %resp = query(obj.visGet,":DISP:DATA?",txHeader + bitHeader + pxBytes);
            %resp = query(obj.visGet,":DISP:DATA?");
            fprintf(obj.visGet,":DISP:DATA?");
            resp = fscanf(obj.visGet);
            % Hard coded pixel indexing for DS1054Z
            % +1 for matlab indexing style
            pxdat = resp((txHeader + bitHeader + 1):end);
            
            % Direct Indexing BMP Read ------------------------------------
            % Elapsed time is 0.151698 seconds.
            %             Bidx = 1:3:length(pxdat);
            %             Gidx = 2:3:length(pxdat);
            %             Ridx = 3:3:length(pxdat);
            %             
            %             Bidx = flipdim(reshape(Bidx,800,480)',1);
            %             Gidx = flipdim(reshape(Gidx,800,480)',1);
            %             Ridx = flipdim(reshape(Ridx,800,480)',1);
            %             
            %             B = pxdat(Bidx);
            %             G = pxdat(Gidx);
            %             R = pxdat(Ridx);
            %             
            %             img = [];
            %             img(:,:,1) = R./255;
            %             img(:,:,2) = G./255;
            %             img(:,:,3) = B./255;
            %  ------------------------------------------------------------
            
 
        
            %  --- Simple BMP Read ----------------------------------------
            % Elapsed time is 0.075029 seconds.
            B = pxdat(1:3:end);
            G = pxdat(2:3:end);
            R = pxdat(3:3:end);
            
            % create matlab CData image
            cimg = reshape([R' G' B']./255,800,480,3);
            
            img = imrotate(cimg,90);
            %  ------------------------------------------------------------
            
            if ColorInvert
                img = imcomplement(img);
                imshow(img)
                imwrite(img,filename,'png');
            end
 
            if nargout == 0
                figure;
                imshow(img,'Border','tight');
                axis equal
                
                % Add current date and username to blank space on Rigol
                % Screen shot
                unames = { getenv('USER'), getenv('USERNAME'), getenv('LOGIN'), getenv('LOGNAME') };
                % empty enteries are whitespace 
                ustr = sortrows( char(unames), -1 );
                
                % Set text color for white on black background (default
                % output of DS1054Z) or black on white
                tColor = [ 1 1 1 ] .* ~logical(ColorInvert);
                
                text( 480, 467, [datestr(now) '; ' ustr(1,:) ], 'Interpreter', 'none', 'Color', tColor )
                img = [];
            end
                
        end         
            
    end
end

