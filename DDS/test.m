N=2^9;  %N为采样点数
s_p=0:N-1;%正弦波一个周期的采样点数
sin_data=sin(2*pi*s_p/N);  %sin_data是初步采样值，浮点数% 编写到这里，大家可以在任务行中显示此时的波形
fix_p_sin_data=fix(sin_data*255); %定点化 fix()函数可以直接去除小数点后的值，使之成为整数
plot(fix_p_sin_data);
for i=1:N
    if fix_p_sin_data(i)<0
        fix_p_sin_data(i)=N+fix_p_sin_data(i);
    else
        fix_p_sin_data(i)=fix_p_sin_data(i);
    end
end%下面是mif文件固定格式，不可更改
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
%好了到此为止，我们就编写完并生成了初始化**mif文件了，下面可以开始verilog编写了，噢，不对，咱们先来利用quartus
