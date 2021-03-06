-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- VOXEL_SIZE = 5e-2
VOXEL_SIZE = 2e-1 -- 20cm

include "transform.lua"

options = {
  tracking_frame = "base_link",
  pipeline = {
    {
      action = "min_max_range_filter",
      min_range = 1.,
      max_range = 60.,
    },
    {
      action = "dump_num_points",
    },
    {
      action = "fixed_ratio_sampler",
      sampling_ratio = 0.1,
    },
    

    -- Gray X-Rays. These only use geometry to color pixels.
    -- {
    --   action = "write_xray_image",
    --   voxel_size = VOXEL_SIZE,
    --   filename = "xray_yz_all",
    --   transform = YZ_TRANSFORM,
    -- },
    --{
    --  action = "voxel_filter_and_remove_moving_objects",
    --  voxel_size = VOXEL_SIZE,
    --},
    {
      action = "intensity_to_color",
      min_intensity = 0.,
      max_intensity = 4095.,
    },
    -- {
    --   action = "intensity_to_color",
    --   min_intensity = 0.,
    --   max_intensity = 1.,
    -- },

    {
      action = "write_xray_image",
      draw_trajectories = true,
      voxel_size = VOXEL_SIZE,
      filename = "xray_xy_all",
      transform = XY_TRANSFORM,
    },
    -- We also write a PLY file at this stage, because gray points look good.
    -- The points in the PLY can be visualized using
    -- https://github.com/googlecartographer/point_cloud_viewer.
    {
      action = "write_ply",
      filename = "points.ply",
    },
    {
      action = "write_pcd",
      filename = "points.pcd",
    },
 
    -- {
    --   action = "write_xray_image",
    --   voxel_size = VOXEL_SIZE,
    --   filename = "xray_xz_all",
    --   transform = XZ_TRANSFORM,
    -- },
    -- {
    --   action = "write_probability_grid",
    --   draw_trajectories = true,
    --   resolution = 0.05,
    --   range_data_inserter = {
    --     insert_free_space = true,
    --     hit_probability = 0.55,
    --     miss_probability = 0.49,
    --   },
    --   filename = "probability_grid",
    -- },
    --{
    --   action = "color_points",
    --   frame_id = "velo_link",
    --   color = { 255., 0., 0. },
    -- },
    --{
    --  action = "voxel_filter_and_remove_moving_objects",
    --  voxel_size = VOXEL_SIZE,
    --},
    -- {
    --   action = "write_xray_image",
    --   voxel_size = VOXEL_SIZE,
    --   filename = "xray_yz_all_color",
    --   transform = YZ_TRANSFORM,
    -- },
    -- {
    --   action = "write_xray_image",
    --   voxel_size = VOXEL_SIZE,
    --   filename = "xray_xy_all_color",
    --   transform = XY_TRANSFORM,
    -- },
    -- {
    --   action = "write_xray_image",
    --   voxel_size = VOXEL_SIZE,
    --   filename = "xray_xz_all_color",
    --   transform = XZ_TRANSFORM,
    -- },
  }
}

return options
