# Use the official .NET 9 SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["Taller7.csproj", "./"]
RUN dotnet restore "Taller7.csproj"

# Copy the rest of the source code
COPY . .

# Build the application
RUN dotnet build "Taller7.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "Taller7.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Use the official .NET 9 runtime image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Expose the port the app runs on
EXPOSE 80

# Set the ASP.NET Core URLs to listen on port 80
ENV ASPNETCORE_URLS=http://+:80

# Set the entry point
ENTRYPOINT ["dotnet", "Taller7.dll"]