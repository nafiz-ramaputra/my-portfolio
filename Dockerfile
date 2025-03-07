# Gunakan image Node.js sebagai base image
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json dan package-lock.json untuk instalasi dependensi
COPY package.json package-lock.json ./

# Gunakan caching untuk mempercepat instalasi dependensi
RUN --mount=type=cache,target=/root/.npm \
    npm ci --legacy-peer-deps

# Copy seluruh kode proyek ke dalam container
COPY . .

# Set flag untuk kompatibilitas OpenSSL 3
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Build aplikasi React
RUN npm run build

# Gunakan image Nginx sebagai base untuk menjalankan aplikasi
FROM nginx:alpine

# Copy build hasil dari tahap sebelumnya ke direktori Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 untuk akses aplikasi
EXPOSE 80

# Jalankan Nginx
CMD ["nginx", "-g", "daemon off;"]
