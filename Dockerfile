.....FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["PlotoApplication/PlotoApplication.csproj", "PlotoApplication/"]
RUN dotnet restore "PlotoApplication/PlotoApplication.csproj"
COPY . .
WORKDIR "/src/PlotoApplication"
RUN dotnet build "PlotoApplication.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "PlotoApplication.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "PlotoApplication.dll"]
