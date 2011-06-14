nexecutions=100;

fprintf('Executing tests on GSO.\n');
fprintf('Number of runs: %d\n', nexecutions);

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

fprintf('Executing f1...\n');
for i=1:nexecutions
    eval_gso_f1;
    results_f1(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f1), std(results_f1));
fprintf('Done\n');

fprintf('Executing f2...\n');
for i=1:nexecutions
eval_gso_f2;
results_f2(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f2), std(results_f2));
fprintf('Done\n');

fprintf('Executing f3...\n');
for i=1:nexecutions
eval_gso_f3;
results_f3(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f3), std(results_f3));
fprintf('Done\n');

fprintf('Executing f4...\n');
for i=1:nexecutions
eval_gso_f4;
results_f4(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f4), std(results_f4));
fprintf('Done\n');

fprintf('Executing f5...\n');
for i=1:nexecutions
eval_gso_f5;
results_f5(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f5), std(results_f5));
fprintf('Done\n');

fprintf('Executing f6...\n');
for i=1:nexecutions
eval_gso_f6;
results_f6(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f6), std(results_f6));
fprintf('Done\n');

fprintf('Executing f8...\n');
for i=1:nexecutions
eval_gso_f8;
results_f8(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f8), std(results_f8));
fprintf('Done\n');

fprintf('Executing f9...\n');
for i=1:nexecutions
eval_gso_f9;
results_f9(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f9), std(results_f9));
fprintf('Done\n');

fprintf('Executing f10...\n');
for i=1:nexecutions
eval_gso_f10;
results_f10(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f10), std(results_f10));
fprintf('Done\n');

fprintf('Executing f11...\n');
for i=1:nexecutions
eval_gso_f11;
results_f11(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f11), std(results_f11));
fprintf('Done\n');

fprintf('Executing f14...\n');
for i=1:nexecutions
eval_gso_f14;
results_f14(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f14), std(results_f14));
fprintf('Done\n');

fprintf('Executing f16...\n');
for i=1:nexecutions
eval_gso_f16;
results_f16(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f16), std(results_f16));
fprintf('Done\n');

fprintf('Executing f17...\n');
for i=1:nexecutions
eval_gso_f17;
results_f17(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f17), std(results_f17));
fprintf('Done\n');

fprintf('Executing f18...\n');
for i=1:nexecutions
eval_gso_f18;
results_f18(i)=min(fx);
end
fprintf('f1\tMédia: %f\tDesvio: %f\n', mean(results_f18), std(results_f18));
fprintf('Done\n');
fprintf('End of tests\n');