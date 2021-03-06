FROM microsoft/dotnet:2.1.403-sdk as builder  
 
RUN mkdir -p /root/src/app/qlik2datarobot
WORKDIR /root/src/app/qlik2datarobot
 
COPY Qlik2DataRobot/Qlik2DataRobot.csproj ./Qlik2DataRobot.csproj
RUN dotnet restore ./Qlik2DataRobot.csproj 

COPY Qlik2DataRobot .
RUN dotnet publish -c release -o published 

FROM microsoft/dotnet:2.1.5-runtime

WORKDIR /root/  
COPY --from=builder /root/src/app/qlik2datarobot/published .

EXPOSE 50052/tcp
EXPOSE 19345/tcp
CMD ["dotnet","./Qlik2DataRobot.dll"]