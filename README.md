# AWS Ansible Playbook in a Docker Image

Do you hate installing Ansible, boto and Python on your pristine
machine just to orchestrate AWS resources?  Well, now you can call
upon a Docker image to encapsulate that for you.

## Running the Docker Image

```bash
docker run -v $(pwd):/app:ro scottbrown/aws-ansible-playbook -e 'somevar=somevalue' playbook.yml
```

## Working with this Project

Whether you are building the image or tagging it, all work is performed
through the magic of Makefiles.

```bash
make build    # builds the docker image
```

## LICENSE

tl;dr MIT License

See [LICENSE](LICENSE) for more details.

