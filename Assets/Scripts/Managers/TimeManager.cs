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
        [SerializeField] private Rigidbody playerRB;
        private void Awake(){
            _fixedDeltaTime = Time.fixedUnscaledDeltaTime;
            timeState = TimeState.Stopped;
         

        }


        public void BatchFixedUpdate(){
            SwitchTimeState();
        }
        

        private void SwitchTimeState(){
            if (gamePaused) return;
            if (playerRB.velocity.x > 1f || playerRB.velocity.x < -1f || playerRB.velocity.y > 1f || playerRB.velocity.y < -1f){
                timeState = TimeState.Normal;
            }
            else{
                timeState = TimeState.Stopped;
            }
            //  if (Input.anyKey) timeState = TimeState.Normal;
           // else timeState = TimeState.Stopped;
            TimeShift();
        }

        private void TimeShift(){
            switch (timeState) {
                case TimeState.Stopped:
                    Time.timeScale = Mathf.Lerp(Time.timeScale,_stoppedTime, timeChangeRate*Time.fixedDeltaTime);
                    Time.fixedDeltaTime = Time.timeScale * _fixedDeltaTime;
                    break;
                case TimeState.Normal:
                    Time.timeScale = Mathf.Lerp(Time.timeScale,_normalTime, timeChangeRate*Time.fixedDeltaTime);
                    Time.fixedDeltaTime = Time.timeScale * _fixedDeltaTime;
                    break;
                default:
                    goto case TimeState.Stopped;
            }
        }
    }
}