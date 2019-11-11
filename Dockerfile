FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["./dotnet_core_hello_world.csproj", "./"]
 

RUN dotnet restore "./dotnet_core_hello_world.csproj"
COPY . .

RUN dotnet build "dotnet_core_hello_world.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "dotnet_core_hello_world.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "dotnet_core_hello_world.dll"]
