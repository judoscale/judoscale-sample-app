FROM nginx:latest

# Copy the NGINX configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

#### BUILD AND DEPLOY COMMAND SEQUENCE
#$> (from project root) cd nginx_sidecar
#$>
#$> docker build --platform=linux/arm64 -t nginx-sidecar-start-header .
#$>
#$> docker tag nginx-sidecar-start-header:latest public.ecr.aws/b1e6w9f4/nginx-sidecar-start-header:latest
#$>
#$> aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/b1e6w9f4
#$>
#$> docker push public.ecr.aws/b1e6w9f4/nginx-sidecar-start-header:latest
