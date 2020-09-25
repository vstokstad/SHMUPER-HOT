﻿using System;
using UnityEngine;

public enum TimeState {
    Stopped = 0,
    Normal = 1
}

public class TimeManager : MonoBehaviour {
    [SerializeField] private float timeChangeRate = 3f;
    private readonly float _normalTime = 1.0f;
    private readonly float _stoppedTime = 0.0f;
    private float _fixedDeltaTime;
    [NonSerialized] public TimeState timeState;
    public bool gamePaused;
    private void Awake(){
        _fixedDeltaTime = Time.fixedUnscaledDeltaTime;
    }

    private void Update(){
        if (!gamePaused) {
            if (Input.anyKey) timeState = TimeState.Normal;
            else if (!Input.anyKey) timeState = TimeState.Stopped;
        }
        TimeShift();
       
    }

    private void TimeShift(){
        switch (timeState) {
            case TimeState.Stopped:
                Time.timeScale = Mathf.Lerp(Time.timeScale, _stoppedTime,
                    timeChangeRate * Time.unscaledDeltaTime);
                Time.fixedDeltaTime = Time.timeScale * _fixedDeltaTime;
                break;
            case TimeState.Normal:
                Time.timeScale = Mathf.Lerp(Time.timeScale, _normalTime,
                    timeChangeRate * Time.unscaledDeltaTime);
                Time.fixedDeltaTime = Time.timeScale * _fixedDeltaTime;
                break;
            default:
                goto case TimeState.Stopped;
        }
    }
}