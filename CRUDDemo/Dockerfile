FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

EXPOSE 80 443 2222
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["CRUDDemo/CRUDDemo.csproj", "CRUDDemo/"]
RUN dotnet restore "CRUDDemo/CRUDDemo.csproj"

COPY . .

WORKDIR "/src/CRUDDemo"
RUN dotnet build "CRUDDemo.csproj" -c Release -o /app/build


FROM build AS publish
RUN dotnet publish "CRUDDemo.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "CRUDDemo.dll"]