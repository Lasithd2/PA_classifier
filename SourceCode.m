data=csvread("datafile.csv");

C=1;
X=data(:,2:10);
Wt=zeros(1,9);
Yt=data(:,11);
lTestCorrect=0;
lTrainCorrect=0;
iterations=[1 2 10];

%replacing values
for i=1:699
    if Yt(i,1)==2
        Yt(i,1)=-1;
    else
        Yt(i,1)=1;
    end        
end

%training
for k=1:size(iterations,2)
 Wt=zeros(1,9);
for i=1:iterations(1,k)
     lTrainCorrect=0;
     

for j=1:466
    Xt=X(j,:);
    P=dot(Wt,Xt); 
   PMatrixTrain(j,1)=P;
    l=max(0,1-(Yt(j,:)*(P)));
   T=l/((norm(Xt))^2+(1/(2*C)));
   Wt=Wt+T*Yt(j,:)*Xt;
   
   if l==0
      lTrainCorrect=lTrainCorrect+1;     
   end
    l=0;
end
end
correctTrainNo(1,k)=lTrainCorrect;
wtMatrix(k,1:9)=Wt;
end

for i=1:size(correctTrainNo,2)
    trainAccuracy=(correctTrainNo(1,i)/466)*100;
    trainAccMatrix(1,i)= trainAccuracy;
end

for i=1:size(iterations,2)
    disp( strcat('The training accuracy for no. of iterations = ', num2str(iterations(1,i))));
    disp(trainAccMatrix(1,i));
end

%testing
for k=1:size(iterations,2)

for i=1:iterations(1,k)
     lTestCorrect=0;
for j=1:233
    Xtnew=X(j+466,:);
    P=dot(wtMatrix(k,1:9),Xtnew); 
    PMatrixTest(j,1)=P;
     l=max(0,1-(Yt(j+466,:)*(P)));
     if l==0
      lTestCorrect=lTestCorrect+1;     
     end
    l=0;
end
end
correctTestNo(1,k)=lTestCorrect;
end

for i=1:size(correctTestNo,2)
    testAccuracy=(correctTestNo(1,i)/233)*100;
    testAccMatrix(1,i)= testAccuracy;
end

for i=1:size(iterations,2)
    disp( strcat('The testing accuracy for no. of iterations = ', num2str(iterations(1,i))));
    disp(testAccMatrix(1,i));
end



