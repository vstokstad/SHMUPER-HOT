using System;
using Actors.Player;
using UnityEngine;

namespace Managers {
    public enum TimeState {
        Stopped = 0,
        Normal = 1
    }

    public class TimeManager : MonoBehaviour {
        [SerializeField] private float timeChangeRate = 2f;
        private readonly float _normalTime = 1.0f;
        private readonly float _stoppedTime = 0.0f;
        private float _fixedDeltaTime;
        [NonSerialized] public TimeState timeState;
        [NonSerialized]public bool gamePaused;
        private void Awake(){
            _fixedDeltaTime = Time.fixedUnscaledDeltaTime;
            timeState = TimeState.Stopped;
         

        }

        private void Start(){
            PlayerInput.move += SwitchTimeState;
        }

        private void Update(){
           
            TimeShift();
       
        }

        private void OnDisable(){
            // ReSharper disable once DelegateSubtraction
            PlayerInput.move -= SwitchTimeState;
        }

        private void SwitchTimeState(){
            if (gamePaused) return;
            timeState = timeState == TimeState.Stopped ? TimeState.Normal : TimeState.Stopped ;
            print("TimeShift");
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
}