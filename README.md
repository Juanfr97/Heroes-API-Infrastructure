# Heroes API - MongoDB Cluster on Kubernetes

---

## Overview

This Terraform project aims to provision and manage a robust infrastructure stack for a cluster-based MongoDB instance running on Kubernetes, deployed on DigitalOcean. Additionally, it will deploy a Node.js API to interact with the MongoDB cluster, serving data related to Marvel and DC superheroes. To ensure data persistence and secure access, the project will utilize Kubernetes Persistent Volume Claims (PVCs), an Ingress Controller, and Let's Encrypt certificates.

The key components of this project include:

- **MongoDB Cluster on Kubernetes**: A MongoDB cluster will be created on Kubernetes on the DigitalOcean platform to store and manage superhero data efficiently.

- **Node.js API**: A Node.js-based API will be deployed to Kubernetes to serve superhero data from the MongoDB cluster to clients.

- **Data Source**: The database will contain information about superheroes from both Marvel and DC universes.

- **Persistent Volume Claims (PVCs)**: PVCs will be used to provide reliable and persistent storage for the MongoDB cluster.

- **Ingress Controller**: An Ingress Controller will be set up to manage external access to the API and MongoDB cluster.

- **Let's Encrypt Certificates**: To ensure secure communication, Let's Encrypt certificates will be used to enable HTTPS access to the API and MongoDB cluster.

This project aims to provide a comprehensive solution for managing superhero data with a resilient MongoDB cluster and a secure API, making it a valuable resource for superhero enthusiasts and developers alike.

## Requirements

The only requirement to run this Terraform project is to have Terraform installed on your local machine. You can download and install Terraform from the official website: [Terraform Downloads](https://www.terraform.io/downloads.html).

No additional software or tools are required for this project.

## Environment Variables

Before running the Terraform project, make sure to set the following environment variables:

- **DO_TOKEN**: Your DigitalOcean API token, which is required for managing your DigitalOcean resources.

- **HEROES_API_URL**: The URL for the Node.js API that will interact with the MongoDB cluster to serve superhero data. Make sure to specify the correct API URL.

- **LETSENCRYPT_EMAIL**: The email address associated with your Let's Encrypt certificate. This is required for secure HTTPS access to the API and MongoDB cluster.

You can set these environment variables in your shell session or include them in a `.env` file in the project directory.

Here's an example of setting these environment variables in a Unix-like shell:

```shell
export TF_VAR_DO_TOKEN=your_digitalocean_token
export TF_VAR_HEROES_API_URL=your-api-url.com
export TF_VAR_CERT_MANAGER_EMAIL=your@email.com
```
