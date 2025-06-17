program test(ALU_inter.TB itb); 
initial 
begin 
itb.reset<=1; 
#10 itb.reset<=0; 
end 
initial 
begin 
driver drv; 
drv = new(itb); 
drv.drive_data(); 
end 
endprogram 
