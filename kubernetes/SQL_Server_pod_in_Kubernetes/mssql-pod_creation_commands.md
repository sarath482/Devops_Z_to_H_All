# Issue

Pulling image "mcr.microsoft.com/mssql/server:2019-latest"
  Warning  Failed     2s    kubelet            Failed to pull image "mcr.microsoft.com/mssql/server:2019-latest": rpc error: code = Unknown desc = context deadline exceeded
  Warning  Failed     2s    kubelet            Error: ErrImagePull
  Normal   BackOff    1s    kubelet            Back-off pulling image "mcr.microsoft.com/mssql/server:2019-latest"
  Warning  Failed     1s    kubelet            Error: ImagePullBackOff

We are facing this issue in dockerdesktop.
