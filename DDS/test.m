N=2^9;  %NΪ��������
s_p=0:N-1;%���Ҳ�һ�����ڵĲ�������
sin_data=sin(2*pi*s_p/N);  %sin_data�ǳ�������ֵ��������% ��д�������ҿ���������������ʾ��ʱ�Ĳ���
fix_p_sin_data=fix(sin_data*255); %���㻯 fix()��������ֱ��ȥ��С������ֵ��ʹ֮��Ϊ����
plot(fix_p_sin_data);
for i=1:N
    if fix_p_sin_data(i)<0
        fix_p_sin_data(i)=N+fix_p_sin_data(i);
    else
        fix_p_sin_data(i)=fix_p_sin_data(i);
    end
end%������mif�ļ��̶���ʽ�����ɸ���
fid=fopen('sp_ram_512x9.mif','w+');
fprintf(fid,'WIDTH=9;\n');
fprintf(fid,'DEPTH=512;\n');
fprintf(fid,'ADDRESS_RADIX=UNS;\n');
fprintf(fid,'DATA_RADIX=UNS;\n');
fprintf(fid,'CONTENT BEGIN \n');
for i=1:N
fprintf(fid,'%d:%d; \n',i-1,fix_p_sin_data(i));
end
fprintf(fid,'END; \n');
fclose(fid);
%���˵���Ϊֹ�����Ǿͱ�д�겢�����˳�ʼ��**mif�ļ��ˣ�������Կ�ʼverilog��д�ˣ��ޣ����ԣ�������������quartus
