using Actors.Enemies;
using UnityEngine;
using static Managers.TagsAsStrings;

namespace Actors.Weapons {
    public class PlasmaControl : MonoBehaviour {
        private readonly float _plasmaDamage = 1f;
        private ParticleSystem _particleSystem;

        private void Awake(){
            _particleSystem = GetComponent<ParticleSystem>();
        }

        private void OnEnable(){
            _particleSystem.Play();
            gameObject.SetActive(true);
        }

        private void OnBecameInvisible(){
            gameObject.SetActive(false);
        }

        private void OnTriggerEnter(Collider other){
            if (!other.gameObject.CompareTag(enemyTag)) return;
            other.gameObject.GetComponent<EnemyController>().TakeDamage(_plasmaDamage);
            gameObject.SetActive(false);
        }
    }
}