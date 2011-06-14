nexecutions=100;

fprintf('Executing tests on GSO\n');

results_f1=zeros(1,nexecutions);
results_f2=zeros(1,nexecutions);
results_f3=zeros(1,nexecutions);
results_f4=zeros(1,nexecutions);
results_f5=zeros(1,nexecutions);
results_f6=zeros(1,nexecutions);
results_f8=zeros(1,nexecutions);
results_f9=zeros(1,nexecutions);
results_f10=zeros(1,nexecutions);
results_f11=zeros(1,nexecutions);
results_f14=zeros(1,nexecutions);
results_f16=zeros(1,nexecutions);
results_f17=zeros(1,nexecutions);
results_f18=zeros(1,nexecutions);

fprintf('Executing f1...');
for i=1:nexecutions
    eval_gso_f1;
    results_f1(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f2...');
for i=1:nexecutions
eval_gso_f2;
results_f2(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f3...');
for i=1:nexecutions
eval_gso_f3;
results_f3(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f4...');
for i=1:nexecutions
eval_gso_f4;
results_f4(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f5...');
for i=1:nexecutions
eval_gso_f5;
results_f5(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f6...');
for i=1:nexecutions
eval_gso_f6;
results_f6(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f8...');
for i=1:nexecutions
eval_gso_f8;
results_f8(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f9...');
for i=1:nexecutions
eval_gso_f9;
results_f9(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f10...');
for i=1:nexecutions
eval_gso_f10;
results_f10(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f11...');
for i=1:nexecutions
eval_gso_f11;
results_f11(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f14...');
for i=1:nexecutions
eval_gso_f14;
results_f14(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f16...');
for i=1:nexecutions
eval_gso_f16;
results_f16(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f17...');
for i=1:nexecutions
eval_gso_f17;
results_f17(i)=min(fx);
end
fprintf('Done\n');

fprintf('Executing f18...');
for i=1:nexecutions
eval_gso_f18;
results_f18(i)=min(fx);
end
fprintf('Done\n');
fprintf('End of tests\n');