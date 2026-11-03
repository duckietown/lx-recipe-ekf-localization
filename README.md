# LX Recipe: Localization (EKF with wheel encoders and AprilTags)

Recipe of the [lx-ekf-localization](https://github.com/duckietown/lx-ekf-localization) learning experience
(solution: [lx-ekf-localization-solution](https://github.com/duckietown/lx-ekf-localization-solution)).
Branch `ente-ros2`: the exercise runs on **ROS 2 (Jazzy, `rmw_zenoh_cpp`)** on the `ente` images; the
remote desktop of the ROS 1 version is gone, its 3D view is replaced by notebook panels.

## What the recipe provides

- `Dockerfile`: workbench image based on `dt-ros2-commons`. The recipe `packages/` and the LX `packages/`
  are copied to the same tree and built with `colcon` (`dt-colcon-build`); plain python packages under
  `packages/` (e.g. `solution`) are importable through `PYTHONPATH`.
- `Dockerfile.vscode`: code editor (`dt-vscode`) with ROS 2 Jazzy, `duckietown_msgs` and the recipe
  packages, so that the notebooks and the integrated terminal talk to the robot's zenoh router
  (`VEHICLE_NAME` or `RosSession(ROBOT)` in a notebook).
- `packages/lx_ros2_tools`: shared helpers used by every ROS 2 LX (`RosSession`, notebook panels
  `ParamPanel`/`ActionButtons`/`ImageView`/`TrajectoryPlot`, `LiveParams`, image conversion, wheel
  parameters). Keep it identical across recipes.
- `packages/encoder_pose`: reference dead-reckoning node (`encoder_pose_node`, publishes
  `~/encoder_pose` as `nav_msgs/Odometry`, `~/reset` Trigger service). It is included by the LX launch
  file so that students can compare their EKF with pure odometry.
- `launchers/default.sh`: `ros2 launch ekf_localization ekf_localization_node.launch.py veh:=$VEHICLE_NAME`
  (the student node from the LX, which also includes `encoder_pose_node`).
- `assets/duckiematrix`: the `loop` map with the AprilTag traffic signs whose positions are in the LX
  `packages/ekf_localization/map.yaml`.

## Dependencies

`apt` dependencies of the workbench image go in [dependencies-apt.txt](./dependencies-apt.txt), those of
the editor image (ROS 2 Jazzy packages) in [dependencies-apt.vscode.txt](./dependencies-apt.vscode.txt),
python dependencies of both in [dependencies-py3.txt](./dependencies-py3.txt) (`dt-apriltags`,
`lib-dt-computer-vision`, `lib-dt-state-estimation` for the notebooks, and `ipywidgets ipympl matplotlib`
for the notebook panels).

## Running

Students only need the LX: `dts code build -R ROBOT`, `dts code workbench [-m] -R ROBOT`,
`dts code editor`. The robot must run the ROS 2 stack (`dts stack up -H ROBOT ros2/duckiebot` and
`dts stack up -H ROBOT ros2-core/default`). To develop the recipe locally:

    dts code editor --recipe /absolute/path/to/lx-recipe-ekf-localization
    dts code workbench -R ROBOT --recipe /absolute/path/to/lx-recipe-ekf-localization

## Duckiematrix 

By default, each LX is compatible with the [Duckiematrix](https://docs.duckietown.com/ente/devmanual-duckiematrix/intro.html).
See the [README in the LX template](https://github.com/duckietown/template-lx/blob/ente/README.md)
for more details on how to deploy this capability through the `dts code` API. 
You can define the exact configuration of the Duckiematrix environment in the 
[assets/duckiematrix](./assets/duckiematrix) directory. For more details see
[the Duckiematrix manual](https://docs.duckietown.com/ente/devmanual-duckiematrix/intro.html).
