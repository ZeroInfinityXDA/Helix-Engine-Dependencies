#!/system/bin/sh
# AUTHOR: TEAM HELIX @ XDA-DEVELOPERS
# Template by @ZeroInfinity, adapted from @RogerF81, improved by @Asiier
# Helix-Engine profile script: Balanced

#Stune
echo 1 > /dev/stune/top-app/schedtune.boost
echo 0 > /dev/stune/background/schedtune.boost
echo 0 > /dev/stune/foreground/schedtune.boost
echo 0 > /dev/stune/schedtune.prefer_idle
echo 0 > /proc/sys/kernel/sched_child_runs_first
echo 0 > /dev/stune/background/schedtune.prefer_idle
echo 1 > /dev/stune/foreground/schedtune.prefer_idle
echo 1 > /dev/stune/top-app/schedtune.prefer_idle
echo 48 > /proc/sys/kernel/sched_nr_migrate
echo 0 > /proc/sys/kernel/sched_initial_task_util

#Cpuset
echo 0-1 > /dev/cpuset/background/cpus
echo 0-1 > /dev/cpuset/system-background/cpus

#Governor
if grep 'schedutil' /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors; then
	#LITTLE
	echo schedutil > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo '1747200' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo '518400' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 500 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo 10000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/iowait_boost_enable
	echo 10 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
	echo 10 > /proc/sys/kernel/sched_walt_init_task_load_pct
	echo 10000000 > /proc/sys/kernel/sched_walt_cpu_high_irqload
	#big
	echo schedutil > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo '1958400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo '806400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 500 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 10000 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/iowait_boost_enable
else
	#LITTLE
	echo interactive > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo '1747200' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
	echo '300000' > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 76 595200:82 883200:85 1171200:87 1324800:91 1555200:95 > /sys/devices/system/cpu/cpufreq/policy0/interactive/target_loads
	echo 90000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_slack
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/timer_rate
	echo 1248000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/hispeed_freq
	echo 0 883200:20000 1555200:40000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/above_hispeed_delay
	echo 400 > /sys/devices/system/cpu/cpufreq/policy0/interactive/go_hispeed_load
	echo 10000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/min_sample_time
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/max_freq_hysteresis
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/boost
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/fast_ramp_down
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/interactive/use_sched_load
	echo 30000 > /sys/devices/system/cpu/cpufreq/policy0/interactive/boostpulse_duration
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/io_is_busy
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/interactive/enable_prediction
	#big
	echo interactive > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo '1958400' > /sys/devices/system/cpu/cpufreq/policy4/scaling_max_freq
	echo '300000' > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
	echo 80 729600:84 979200:86 1344000:88 1574400:91 1804800:95 > /sys/devices/system/cpu/cpufreq/policy4/interactive/target_loads
	echo 90000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_slack
	echo 1574400 > /sys/devices/system/cpu/cpufreq/policy4/interactive/hispeed_freq
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/timer_rate
	echo 0 979200:20000 1574400:40000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/above_hispeed_delay
	echo 400 > /sys/devices/system/cpu/cpufreq/policy4/interactive/go_hispeed_load
	echo 10000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/min_sample_time
	echo 20000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/max_freq_hysteresis
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/boost
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/interactive/fast_ramp_down
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/interactive/use_sched_load
	echo 30000 > /sys/devices/system/cpu/cpufreq/policy4/interactive/boostpulse_duration
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/io_is_busy
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/interactive/enable_prediction
	#HMP tunables
	echo 60 > /proc/sys/kernel/sched_downmigrate
	echo 70 > /proc/sys/kernel/sched_group_downmigrate
	echo 80 > /proc/sys/kernel/sched_upmigrate
	echo 90 > /proc/sys/kernel/sched_group_upmigrate
	echo 10 > /proc/sys/kernel/sched_small_wakee_task_load
	echo 10 > /proc/sys/kernel/sched_init_task_load
	echo 1 > /proc/sys/kernel/sched_enable_power_aware
	echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
	echo 30 > /proc/sys/kernel/sched_big_waker_task_load
	echo 2 > /proc/sys/kernel/sched_window_stats_policy
	echo 5 > /proc/sys/kernel/sched_ravg_hist_size
	echo 9 > /proc/sys/kernel/sched_upmigrate_min_nice
	echo 7 > /proc/sys/kernel/sched_spill_nr_run
	echo 80 > /proc/sys/kernel/sched_spill_load
	echo 1 > /proc/sys/kernel/sched_enable_thread_grouping
	echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
	echo 110 > /proc/sys/kernel/sched_wakeup_load_threshold
	echo 10 > /proc/sys/kernel/sched_rr_timeslice_ms
	echo 1 > /proc/sys/kernel/sched_enable_power_aware
	echo 1 > /proc/sys/kernel/sched_migration_fixup
	echo 0 > /proc/sys/kernel/sched_autogroup_enabled
	echo 200000 > /proc/sys/kernel/sched_freq_inc_notify
	echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
	echo 1000 > /proc/sys/kernel/sched_select_prev_cpu_us
	#Input boost
	echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0:883200 1:0 2:0 3:0 4:806400 5:0 6:0 7:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 460 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo N > /sys/module/msm_performance/parameters/touchboost/sched_boost_on_input
fi

#Touchboost
echo 0 > /sys/module/msm_performance/parameters/touchboost

#I/0
echo "cfq" > /sys/block/sda/queue/scheduler
echo 1024 > /sys/block/sda/queue/read_ahead_kb
echo 128 > /sys/block/sda/queue/nr_requests
echo 0 > /sys/block/sda/queue/add_random
echo 0 > /sys/block/sda/queue/iostats
echo 1 > /sys/block/sda/queue/nomerges
echo 0 > /sys/block/sda/queue/rotational
echo 1 > /sys/block/sda/queue/rq_affinity

#TCP
echo 1 > /proc/sys/net/ipv4/tcp_low_latency

#LMK
chown root /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "12288,15360,18432,21504,36864,53760" > /sys/module/lowmemorykiller/parameters/minfree
echo 0 > /sys/module/lowmemorykiller/parameters/debug_level

#VM
echo 1500 > /proc/sys/vm/dirty_expire_centisecs
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 3 > /proc/sys/vm/page-cluster
echo 30 > /proc/sys/vm/swappiness
echo 70 > /proc/sys/vm/vfs_cache_pressure
echo 15 > /proc/sys/vm/dirty_ratio
echo 10 > /proc/sys/vm/dirty_background_ratio
echo 1 > /proc/sys/vm/overcommit_memory
echo 50 > /proc/sys/vm/overcommit_ratio
echo 20480 > /proc/sys/vm/min_free_kbytes
echo 64 > /proc/sys/kernel/random/read_wakeup_threshold
echo 896 > /proc/sys/kernel/random/write_wakeup_threshold
