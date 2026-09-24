# Dockerfile del repositorio base.
# Contiene cinco malas practicas deliberadas. Cada una lleva su numero en la
# linea anterior. Corregirlas es el bloque A1 de la guia del laboratorio.

FROM public.ecr.aws/lambda/nodejs:20 AS build

WORKDIR ${LAMBDA_TASK_ROOT}

COPY package.json package-lock.json ./

RUN npm ci

COPY src ./src

RUN npm run build


FROM public.ecr.aws/lambda/nodejs:20 AS runtime

WORKDIR ${LAMBDA_TASK_ROOT}

COPY --from=build \
    ${LAMBDA_TASK_ROOT}/dist/handler.js \
    ${LAMBDA_TASK_ROOT}/dist/handler.js

CMD ["dist/handler.handler"]
